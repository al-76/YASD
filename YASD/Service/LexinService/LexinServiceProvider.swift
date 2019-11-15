//
//  LexinServiceProvider.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 13/08/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import UIKit

//protocol ProtocolLexinServiceParser {
//    associatedtype ResultType
//
//    func getUrl() -> String
//    func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)
//    func parse(text: String) throws -> [ResultType]
//}

class LexinServiceProviderWords {
    private let defaultParser: LexinServiceParser
    private let parsers: [String: LexinServiceParser]
    
    init(defaultParser: LexinServiceParser, folketsParser: LexinServiceParser, swedishParser: LexinServiceParser) {
        self.defaultParser = defaultParser
        self.parsers = [ "eng": folketsParser,
                        "swe": swedishParser ]
    }
    
    func getParser(language: LexinServiceParameters.Language) -> LexinServiceParser {
        guard let parser = parsers[language.code] else {
            return defaultParser
        }
        return parser
    }
}

class LexinServiceProviderSuggestion {
    private let defaultParser: LexinServiceSuggestionParser
    private let parsers: [String: LexinServiceSuggestionParser]
    
    init(defaultParser: LexinServiceSuggestionParser, folketsParser: LexinServiceSuggestionParser) {
        self.defaultParser = defaultParser
        self.parsers = [ "eng": folketsParser ]
    }
    
    func getParser(language: LexinServiceParameters.Language) -> LexinServiceSuggestionParser {
        guard let parser = parsers[language.code] else {
            return defaultParser
        }
        return parser
    }
}

