//
//  LexinServiceProviderWords.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15.10.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit

protocol LexinParserWords {
    func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters
    func parse(text: String) throws -> [LexinWord]
}

// Default Lexin
class LexinParserWordsDefault : LexinParserWords {
    private static let URL = "https://lexin.nada.kth.se/lexin/lexin/"
    private static let SOUND_URL = "https://lexin.nada.kth.se/sound/"
    
    internal let htmlParser: HtmlParser
    
    init(htmlParser: HtmlParser) {
        self.htmlParser = htmlParser
    }
    
    func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters {
        return (url: getUrl(), parameters: getRequestParameters(word, language))
    }
    
    private func getUrl() -> String {
        return LexinParserWordsDefault.URL + "lookupword"
    }
    
    private func getRequestParameters(_ word: String, _ language: String) -> (String?, [String: String]?) {
        let body = "7|0|7|" + LexinParserWordsDefault.URL + "|FCDCCA88916BAACF8B03FB48D294BA89|se.jojoman.lexin.lexingwt.client.LookUpService|lookUpWord|se.jojoman.lexin.lexingwt.client.LookUpRequest/682723451|" +
            language + "|" +
            word + "|1|2|3|4|1|5|5|1|6|0|7|"
        let parameters = ["Content-Type": "text/x-gwt-rpc;charset=UTF-8",
                        "X-GWT-Module-Base": LexinParserWordsDefault.URL,
                        "X-GWT-Permutation": "28B9DF7353B58D7F508C74030B83DEAE"]
        return (body, parameters)
    }
    
    func parse(text: String) throws -> [LexinWord] {
        return try htmlParser.parse(html: text, query: "Word").map { word -> LexinWord in
                let baseLang = try LexinParserWordsDefault.parseLang("BaseLang > ", with: word)
                let targetLang = try LexinParserWordsDefault.parseLang("TargetLang > ", with: word)
                let value = (try word.attribute("Value")).removeQuotes()
                let type = (try word.attribute("Type")).removeQuotes()
                return LexinWord(word: value,
                                              type: type,
                                              baseLang: baseLang,
                                              targetLang: targetLang,
                                              lexemes: nil)
        }
    }
    
    fileprivate static func parseLang(_ root: String, with element: HtmlParserElement) throws -> LexinWord.Lang {
        return LexinWord.Lang(meaning: try parseMeaning(root, with: element),
                                           phonetic: parsePhonetic((try? element.selectText(root + "Phonetic")) ?? ""),
                    inflection: try? element.selectTexts(root + "Inflection"),
                    grammar: try? element.selectText(root + "Graminfo"),
                    example: try? element.selectLexinServiceResultItems(root + "Example"),
                    idiom: try? element.selectLexinServiceResultItems(root + "Idiom"),
                    compound: try? element.selectLexinServiceResultItems(root + "Compound"),
                    translation: try? element.selectText(root + "Translation"),
                    reference: try? parseReference(root, with: element),
                    synonym: try? element.selectTexts(root + "Synonym"),
                    soundUrl: try? parseSoundUrl(root, with: element))
    }
    
    fileprivate static func parseReference(_ root: String, with element: HtmlParserElement) throws -> String? {
        let reference = try? element.selectElements(root + "Reference").first
        if let type = try reference?.attribute("Type"),
            (!type.isEmpty && type.removeQuotes() != "see") {
            return ""
        }
        return try? reference?.attribute("Value").removeQuotes()
    }
    
    fileprivate static func parseSoundUrl(_ root: String, with element: HtmlParserElement) throws -> String? {
        let phonetic = try? element.selectElements(root + "Phonetic").first
        if let res = try? phonetic?.attribute("File").removeQuotes() {
            return SOUND_URL + res.replaceNonAscii()
        }
        return nil
    }
    
    private static func parseMeaning(_ root: String, with element: HtmlParserElement) throws -> String? {
        var meaning = try? element.selectText(root + "Meaning")
        meaning = (meaning == "") ? (try? element.selectTexts(root + "Definition").first) : meaning
        meaning = (meaning == "") ? (try? element.selectTexts(root + "Gramcom").first) : meaning
        return meaning?.removeQuotes()
    }
}

class LexinParserWordsSwedish : LexinParserWordsDefault {
    override func parse(text: String) throws -> [LexinWord] {
        return try htmlParser.parse(html: text.replacingOccurrences(of: "\\n", with: ""), query: "Lemma")
            .map { word ->LexinWord in
            let value = (try word.attribute("Value")).removeQuotes()
            let type = (try word.attribute("Type")).removeQuotes()
            let lexems = try LexinParserWordsSwedish.parseLexems("Lexeme", with: word)
            return LexinWord(word: value, type: type, baseLang: nil, targetLang: nil, lexemes: lexems)
        }
    }
    
    private static func parseLexems(_ id: String, with element: HtmlParserElement) throws -> [LexinWord.Lang] {
        let phonetic = parsePhonetic(try element.selectText("Phonetic"))
        var soundUrl: String? = nil
        if let phoneticElement = try element.selectElements("Phonetic").first {
            soundUrl = try parseSoundUrl("", with: phoneticElement)
        }
        let inflection = try element.selectTexts("Inflection")
        var langs: [LexinWord.Lang] = try element.selectElements(id).map {
            var lang = try parseLang("", with: $0)
            lang.phonetic = phonetic
            lang.inflection = inflection
            lang.soundUrl = soundUrl
            return lang
        }
        if langs.isEmpty {
            let reference = try? parseReference("", with: element)
            langs.append(LexinWord.Lang(meaning: nil, phonetic: phonetic, inflection: inflection, grammar: nil, example: nil, idiom: nil, compound: nil, translation: nil, reference: reference, synonym: nil, soundUrl: soundUrl))
        }
        return langs
    }
}

private extension HtmlParserElement {
    func selectLexinServiceResultItems(_ query: String) throws -> [LexinWord.Item] {
        return try selectElements(query).map { element in
            let value = try element.text()
            return LexinWord.Item(id: try element.attribute("ID"),
                                        value: (value == "") ? try element.attribute("value") : value) }
    }
    
    func selectValue(_ query: String) throws -> String? {
        return try selectElements(query).first?.attribute("value").removeQuotes()
    }
    
    func selectValues(_ query: String) throws -> [String?] {
        return try selectElements(query).map { try $0.attribute("value").removeQuotes() }
    }
}

private extension String {
    func removeQuotes() -> String {
        return self.replacingOccurrences(of: "\\\"", with: "")
            .replacingOccurrences(of: "xA0", with: " ")
    }
    
    func replaceNonAscii() -> String {
        return self.replacingOccurrences(of: "ä", with: "0344")
            .replacingOccurrences(of: "Ä", with: "0344")
    }
}

// Folkets Lexikon
class LexinParserWordsFolkets : LexinParserWords {
    private static let URL = "https://folkets-lexikon.csc.kth.se/folkets/folkets/"
    private static let SOUND_URL = "https://lexin.nada.kth.se/sound/"
    private static let wordTypes = ["ab": "adv.",
                                     "vb": "verb",
                                     "nn": "subst.",
                                     "pn": "pron.",
                                     "jj": "adj.",
                                     "rg": "räkne",
                                     "abbrev": "förk.",
                                     "kn": "konj.",
                                     "in": "interj.",
                                     "pp": "prep."]
    
    private let htmlParser: HtmlParser
    
    init(htmlParser: HtmlParser) {
        self.htmlParser = htmlParser
    }
    
    func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters {
        return (url: getUrl(), parameters: getRequestparameters(word, language))
    }
    
    private func getUrl() -> String {
        return LexinParserWordsFolkets.URL + "lookupword"
    }
    
    private func getRequestparameters(_ word: String, _ language: String) -> (String?, [String: String]?) {
        let body = "7|0|6|" + LexinParserWordsFolkets.URL + "|1F6DF5ACEAE7CE88AACB1E5E4208A6EC|se.algoritmica.folkets.client.LookUpService|lookUpWord|se.algoritmica.folkets.client.LookUpRequest/1089007912|" +
            word.lowercased() + "|1|2|3|4|1|5|5|1|0|0|6|"
        let parameters = ["Content-Type": "text/x-gwt-rpc;charset=UTF-8",
                        "Proxy-Authorization": "Basic cm9ib3QuYWw3NkBnbWFpbC5jb206M2FUOURLeXlYTGlNSG82aE51WFQ=",
                        "Referer" : "https://folkets-lexikon.csc.kth.se/folkets",
                        "X-GWT-Module-Base": LexinParserWordsFolkets.URL,
                        "X-GWT-Permutation": "B3C49266B86D6B1708051F4318E5E0D1"]
        return (body, parameters)
    }
    
    func parse(text: String) throws -> [LexinWord] {
        return try htmlParser.parse(html: text.replacingOccurrences(of: "\\", with: ""),
                                    query: "word")
            .map { word ->LexinWord in
            let value = (try word.attribute("value")).removeQuotes()
            let type = LexinParserWordsFolkets.parseType(type: (try word.attribute("class")).removeQuotes())
            let baseLang = try LexinParserWordsFolkets.parseLang(word)
            let targetLang = try LexinParserWordsFolkets.parseTranslatedLang(word)
            return LexinWord(word: value, type: type, baseLang: baseLang, targetLang: targetLang, lexemes: nil)
        }
    }
    
    private static func parseType(type: String) -> String {
        return wordTypes[type] ?? type
    }
    
    private static func parseLang(_ element: HtmlParserElement) throws -> LexinWord.Lang {
        let lang = LexinWord.Lang(meaning: try? element.selectValue("definition"),
                                               phonetic: parsePhonetic((try? element.selectValue("phonetic")) ?? ""),
                                           inflection: try? element.selectValues( "inflection"),
                                           grammar: try? element.selectValue("graminfo"),
                                           example: try? element.selectLexinServiceResultItems("example"),
                                           idiom: try? element.selectLexinServiceResultItems("idiom"),
                                           compound: nil,
                                           translation: try? element.selectValue("translation"),
                                           reference: nil,
                                           synonym: try? element.selectValues("synonym"),
                                           soundUrl: try? parseSoundUrl(element: element))
        return lang
    }
    
    private static func parseTranslatedLang(_ element: HtmlParserElement) throws -> LexinWord.Lang {
        let example = try element.selectElements("example")
            .map { LexinWord.Item(id: try $0.attribute("id"), value: (try $0.selectValue("translation") ?? "")) }
        let lang = LexinWord.Lang(meaning: nil, phonetic: nil, inflection: nil, grammar: nil, example: example, idiom: nil, compound: nil, translation: nil, reference: nil, synonym: nil, soundUrl: nil)
        return lang
    }
    
    private static func parseSoundUrl(element: HtmlParserElement) throws -> String? {
        let phonetic = try? element.selectElements("phonetic").first
        if let res = try? phonetic?.attribute("soundFile").removeQuotes() {
            return SOUND_URL + res.replacingOccurrences(of: "swf", with: "mp3").replaceNonAscii()
        }
        return nil
    }
}

private func parsePhonetic(_ phonetic: String) -> String {
    if phonetic.isEmpty {
        return ""
    }
    
    let symbols = [("+", "‿"),
                    ("@", "ng"),
                    ("$", "sj"),
                    ("2", "²")]
    var res = phonetic
    
    if let regex = try? NSRegularExpression(pattern: "\\\\u([0-9a-fA-F]{1,4})", options: []) {
        for match in regex.matches(in: res, options: [], range:NSMakeRange(0, res.count)) {
            let a = res.substring(with: match.range(at: 0))
            if let b = Int(res.substring(with: match.range(at: 1)), radix: 16),
                let uc = UnicodeScalar(b) {
                res = res.replacingOccurrences(of: a, with: String(Character(uc)))
            }
        }
    }
    
    for symbol in symbols {
        res = res.replacingOccurrences(of: symbol.0, with: symbol.1)
    }
    
    for symbol in res.filter({ $0.isUppercase }) {
        res = res.replacingOccurrences(of: String(symbol), with: "'" + symbol.lowercased())
    }
    
    return res
}

private extension String {
    func substring(with nsrange: NSRange) -> Substring {
        guard let range = Range(nsrange, in: self) else { return "" }
        return self[range]
    }
}
