//
//  LexinServiceProvider.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 13/08/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import UIKit

protocol ProtocolLexinServiceParser {
    associatedtype ResultType
    
    func getUrl() -> String
    func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)
    func parse(text: String) throws -> [ResultType]
}

class LexinServiceProvider<T: ProtocolLexinServiceParser> {
    private let defaultParser: T//LexinServiceParser
    private let parsers: [String: T]//LexinServiceParser]
    
    init(defaultParser: T/*LexinServiceParser*/, folketsParser: T/*LexinServiceParser*/, swedishParser: T/*LexinServiceParser*/) {
        self.defaultParser = defaultParser
        self.parsers = [ "eng": folketsParser,
                        "swe": swedishParser ]
    }
    
    func getParser(language: LexinServiceParameters.Language) -> T { //LexinServiceParser {
        guard let parser = parsers[language.code] else {
            return defaultParser
        }
        return parser
    }
}

