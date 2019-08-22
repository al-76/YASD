//
//  LexinServiceProvider.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 13/08/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import UIKit

class LexinServiceProvider {
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

protocol LexinServiceParser {
    func getUrl() -> String
    func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)
    func parseHtml(text: String) throws -> [LexinServiceResultItem]
}

// Default Lexin
class LexinServiceParserDefault : LexinServiceParser {
    private static let URL: String = "https://lexin.nada.kth.se/lexin/lexin/"
    
    internal let htmlParser: HtmlParser
    
    init(htmlParser: HtmlParser) {
        self.htmlParser = htmlParser
    }
    
    func getUrl() -> String {
        return LexinServiceParserDefault.URL + "lookupword"
    }
    
    func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?) {
        let body = "7|0|7|" + LexinServiceParserDefault.URL + "|FCDCCA88916BAACF8B03FB48D294BA89|se.jojoman.lexin.lexingwt.client.LookUpService|lookUpWord|se.jojoman.lexin.lexingwt.client.LookUpRequest/682723451|" +
            parameters + "|" +
            word + "|1|2|3|4|1|5|5|1|6|0|7|"
        let headers = [ "Content-Type": "text/x-gwt-rpc;charset=UTF-8",
                        "X-GWT-Module-Base": LexinServiceParserDefault.URL,
                        "X-GWT-Permutation": "28B9DF7353B58D7F508C74030B83DEAE" ]
        return (body, headers)
    }
    
    func parseHtml(text: String) throws -> [LexinServiceResultItem] {
        return try htmlParser.parse(html: text, query: "Word").map { word -> LexinServiceResultItem in
                let baseLang = try LexinServiceParserDefault.parseLang(root: "BaseLang > ", element: word)
                let targetLang = try LexinServiceParserDefault.parseLang(root: "TargetLang > ", element: word)
                let value = (try word.attribute("Value")).removeQuotes()
                let type = (try word.attribute("Type")).removeQuotes()
                return LexinServiceResultItem(word: value,
                                              type: type,
                                              baseLang: baseLang,
                                              targetLang: targetLang,
                                              lexemes: nil)
        }
    }
    
    fileprivate static func parseLang(root: String, element: HtmlParserElement) throws -> LexinServiceResultItem.Lang {
        return LexinServiceResultItem.Lang(meaning: try parseMeaning(root: root, element: element),
                    phonetic: try? element.selectText(root + "Phonetic"),
                    inflection: try? element.selectTexts(root + "Inflection"),
                    grammar: try? element.selectText(root + "Graminfo"),
                    example: try? element.selectLexinServiceResultItems(root + "Example"),
                    idiom: try? element.selectLexinServiceResultItems(root + "Idiom"),
                    compound: try? element.selectLexinServiceResultItems(root + "Compound"),
                    translation: try? element.selectText(root + "Translation"),
                    reference: try? parseReference(root: root, element: element),
                    synonym: try? element.selectTexts(root + "Synonym"))
    }
    
    fileprivate static func parseReference(root: String, element: HtmlParserElement) throws -> String? {
        let reference = try? element.selectElements(root + "Reference").first
        return try? reference?.attribute("Value").removeQuotes()
    }
    
    fileprivate static func parseMeaning(root: String, element: HtmlParserElement) throws -> String? {
        var meaning = try? element.selectText(root + "Meaning")
        meaning = (meaning == "") ? (try? element.selectTexts(root + "Definition").first) : meaning
        meaning = (meaning == "") ? (try? element.selectTexts(root + "Gramcom").first) : meaning
        return meaning
    }
}

class LexinServiceSwedish : LexinServiceParserDefault {
    override func parseHtml(text: String) throws -> [LexinServiceResultItem] {
        return try htmlParser.parse(html: text.replacingOccurrences(of: "\\n", with: ""), query: "Lemma")
            .map { word ->LexinServiceResultItem in
            let value = (try word.attribute("Value")).removeQuotes()
            let type = (try word.attribute("Type")).removeQuotes()
            let lexems = try LexinServiceSwedish.parseLexems(id: "Lexeme", element: word)
            return LexinServiceResultItem(word: value, type: type, baseLang: nil, targetLang: nil, lexemes: lexems)
        }
    }
    
    fileprivate static func parseLexems(id: String, element: HtmlParserElement) throws -> [LexinServiceResultItem.Lang] {
        let phonetic = try element.selectText("Phonetic")
        var langs: [LexinServiceResultItem.Lang] = try element.selectElements(id).map {
            var lang = try parseLang(root: "", element: $0)
            lang.phonetic = phonetic
            return lang
        }
        if langs.isEmpty {
            let reference = try? parseReference(root: "", element: element)
            langs.append(LexinServiceResultItem.Lang(meaning: nil, phonetic: phonetic, inflection: nil, grammar: nil, example: nil, idiom: nil, compound: nil, translation: nil, reference: reference, synonym: nil))
        }
        return langs
    }
}

fileprivate extension HtmlParserElement {
    func selectLexinServiceResultItems(_ query: String) throws -> [LexinServiceResultItem.Item] {
        return try selectElements(query).map { element in
            let value = try element.text()
            return LexinServiceResultItem.Item(id: try element.attribute("ID"),
                                        value: (value == "") ? try element.attribute("value") : value) }
    }
    
    func selectValue(_ query: String) throws -> String? {
        return try selectElements(query).first?.attribute("value").removeQuotes()
    }
    
    func selectValues(_ query: String) throws -> [String?] {
        return try selectElements(query).map { try $0.attribute("value").removeQuotes() }
    }
}

fileprivate extension String {
    func removeQuotes() -> String {
        return self.replacingOccurrences(of: "\\\"", with: "")
    }
}

// Folkets Lexikon
class LexinServiceParserFolkets : LexinServiceParser {
    private static let URL = "https://folkets-lexikon.csc.kth.se/folkets/folkets/"
    private static let wordTypes = [ "ab": "adv.",
                                     "vb": "verb",
                                     "nn": "subst.",
                                     "pn": "pron.",
                                     "jj": "adj.",
                                     "rg": "räkne",
                                     "abbrev": "förk.",
                                     "kn": "konj.",
                                     "in": "interj.",
                                     "pp": "prep." ]
    
    private let htmlParser: HtmlParser
    
    init(htmlParser: HtmlParser) {
        self.htmlParser = htmlParser
    }
    
    func getUrl() -> String {
        return LexinServiceParserFolkets.URL + "lookupword"
    }
    
    func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?) {
        let body = "7|0|6|" + LexinServiceParserFolkets.URL + "|1F6DF5ACEAE7CE88AACB1E5E4208A6EC|se.algoritmica.folkets.client.LookUpService|lookUpWord|se.algoritmica.folkets.client.LookUpRequest/1089007912|" +
            word.lowercased() + "|1|2|3|4|1|5|5|1|0|0|6|"
        let headers = [ "Content-Type": "text/x-gwt-rpc;charset=UTF-8",
                        "Proxy-Authorization": "Basic cm9ib3QuYWw3NkBnbWFpbC5jb206M2FUOURLeXlYTGlNSG82aE51WFQ=",
                        "Referer" : "https://folkets-lexikon.csc.kth.se/folkets",
                        "X-GWT-Module-Base": LexinServiceParserFolkets.URL,
                        "X-GWT-Permutation": "B3C49266B86D6B1708051F4318E5E0D1" ]
        return (body, headers)
    }
    
    func parseHtml(text: String) throws -> [LexinServiceResultItem] {
        return try htmlParser.parse(html: text.replacingOccurrences(of: "\\", with: ""),
                                    query: "word")
            .map { word ->LexinServiceResultItem in
            let value = (try word.attribute("value")).removeQuotes()
            let type = LexinServiceParserFolkets.parseType(type: (try word.attribute("class")).removeQuotes())
            let baseLang = try LexinServiceParserFolkets.parseLang(element: word)
            let targetLang = try LexinServiceParserFolkets.parseTranslatedLang(element: word)
            return LexinServiceResultItem(word: value, type: type, baseLang: baseLang, targetLang: targetLang, lexemes: nil)
        }
    }
    
    fileprivate static func parseType(type: String) -> String {
        return wordTypes[type] ?? type
    }
    
    fileprivate static func parseLang(element: HtmlParserElement) throws -> LexinServiceResultItem.Lang {
        let lang = LexinServiceResultItem.Lang(meaning: try? element.selectValue("definition"),
                                           phonetic: try? element.selectValue("phonetic"),
                                           inflection: try? element.selectValues( "inflection"),
                                           grammar: try? element.selectValue("graminfo"),
                                           example: try? element.selectLexinServiceResultItems("example"),
                                           idiom: try? element.selectLexinServiceResultItems("idiom"),
                                           compound: nil,
                                           translation: try? element.selectValue("translation"),
                                           reference: nil,
                                           synonym: try? element.selectValues("synonym"))
        return lang
    }
    
    fileprivate static func parseTranslatedLang(element: HtmlParserElement) throws -> LexinServiceResultItem.Lang {
        let example = try element.selectElements("example")
            .map { LexinServiceResultItem.Item(id: try $0.attribute("id"), value: (try $0.selectValue("translation") ?? "")) }
        let lang = LexinServiceResultItem.Lang(meaning: nil, phonetic: nil, inflection: nil, grammar: nil, example: example, idiom: nil, compound: nil, translation: nil, reference: nil, synonym: nil)
        return lang
    }
}
