//
//  DefaultHtmlParser.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 03.07.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import SwiftSoup

class DefaultHtmlParser: HtmlParser {
    private class SwiftSoupElement : HtmlParserElement {
        let element: SwiftSoup.Element
        
        init(element: SwiftSoup.Element) {
            self.element = element
        }
        
        func attribute(_ id: String) throws -> String {
            return try element.attr(id)
        }
        
        func text() throws -> String {
            return try element.text()
        }
        
        func selectText(_ query: String) throws -> String  {
            return try element.select(query).text()
        }
        
        func selectTexts(_ query: String) throws -> [String] {
            return try element.select(query).map { try $0.text() }
        }
        
        func selectElements(_ query: String) throws -> [HtmlParserElement] {
            return try element.select(query).map { SwiftSoupElement(element: $0) }
        }
    }
    
    func parse(html: String, query: String) throws -> [HtmlParserElement] {
        return (try SwiftSoup.parse(html.htmlDecoded).select(query).map { SwiftSoupElement(element: $0) })
    }
}

private extension String {
    var htmlDecoded: String {
        let transformed = self.applyingTransform(.init("Hex-Any"), reverse: false) ?? self
        let unescaped = (try? Entities.unescape(transformed)) ?? transformed
        return unescaped.replacingOccurrences(of: "\\", with: "")
    }
}
