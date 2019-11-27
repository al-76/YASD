
//
//  File.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15/06/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import SwiftSoup

protocol HtmlParserElement {
    func attribute(_ id: String) throws -> String
    func text() throws -> String
    func selectText(_ query: String) throws -> String
    func selectTexts(_ query: String) throws -> [String]
    func selectElements(_ query: String) throws -> [HtmlParserElement]
}

class HtmlParser {
    private class SwiftSoupElement : HtmlParserElement {
        let element: SwiftSoup.Element
        
        init(element: SwiftSoup.Element) {
            self.element = element
        }
        
        func attribute(_ id: String) throws -> String {
            return try element.attr(id).htmlDecoded
        }
        
        func text() throws -> String {
            return try element.text().htmlDecoded
        }
        
        func selectText(_ query: String) throws -> String  {
            return try element.select(query).text().htmlDecoded
        }
        
        func selectTexts(_ query: String) throws -> [String] {
            return try element.select(query).map { try $0.text().htmlDecoded }
        }
        
        func selectElements(_ query: String) throws -> [HtmlParserElement] {
            return try element.select(query).map { SwiftSoupElement(element: $0) }
        }
    }
    
    func parse(html: String, query: String) throws -> [HtmlParserElement] {
        return (try SwiftSoup.parse(html).select(query).map { SwiftSoupElement(element: $0) })
    }
}

// Mapping from XML/HTML character entity reference to character
// From http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
private let characterEntities : [Substring : Character] = [
    // XML predefined entities:
    "&quot;" : "\"",
    "&amp;" : "&",
    "&apos;": "'",
    "&lt;": "<",
    "&gt;"      : ">",
    
    // HTML character entity references:
    "&nbsp;"    : "\u{00a0}",
    // ...
    "&diams;"   : "♦",
]

private extension String {
    var htmlDecoded: String {
        // ===== Utility functions =====
        
        // Convert the number in the string to the corresponding
        // Unicode character, e.g.
        //    decodeNumeric("64", 10)   --> "@"
        //    decodeNumeric("20ac", 16) --> "€"
        func decodeNumeric(_ string : Substring, base : Int) -> Character? {
            guard let code = UInt32(string, radix: base),
                let uniScalar = UnicodeScalar(code) else { return nil }
            return Character(uniScalar)
        }
        
        // Decode the HTML character entity to the corresponding
        // Unicode character, return `nil` for invalid input.
        //     decode("&#64;")    --> "@"
        //     decode("&#x20ac;") --> "€"
        //     decode("&lt;")     --> "<"
        //     decode("&foo;")    --> nil
        func decode(_ entity : Substring) -> Character? {
            
            if entity.hasPrefix("&#x") || entity.hasPrefix("&#X") {
                return decodeNumeric(entity.dropFirst(3).dropLast(), base: 16)
            } else if entity.hasPrefix("&#") {
                return decodeNumeric(entity.dropFirst(2).dropLast(), base: 10)
            } else {
                return characterEntities[entity]
            }
        }
        
        // ===== Method starts here =====
        
        var result = ""
        var position = startIndex
        
        // Find the next '&' and copy the characters preceding it to `result`:
        while let ampRange = self[position...].range(of: "&") {
            result.append(contentsOf: self[position ..< ampRange.lowerBound])
            position = ampRange.lowerBound
            
            // Find the next ';' and copy everything from '&' to ';' into `entity`
            guard let semiRange = self[position...].range(of: ";") else {
                // No matching ';'.
                break
            }
            let entity = self[position ..< semiRange.upperBound]
            position = semiRange.upperBound
            
            if let decoded = decode(entity) {
                // Replace by decoded character:
                result.append(decoded)
            } else {
                // Invalid entity, copy verbatim:
                result.append(contentsOf: entity)
            }
        }
        // Copy remaining characters to `result`:
        result.append(contentsOf: self[position...])
        return result
    }
}
