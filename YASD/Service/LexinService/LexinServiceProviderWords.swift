//
//  LexinServiceProviderWords.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15.10.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit

//typealias LexinServiceProviderWords = LexinServiceProvider<ProtocolLexinServiceParser>

//protocol LexinServiceParser {
//    func getUrl() -> String
//    func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)
//    func parse(text: String) throws -> [LexinServiceResultItem]
//}

internal extension ProtocolLexinServiceParser {
    typealias ResultType = LexinServiceResultItem
}

// Default Lexin
class LexinServiceParserDefault : ProtocolLexinServiceParser {
    private static let URL = "https://lexin.nada.kth.se/lexin/lexin/"
    private static let SOUND_URL = "https://lexin.nada.kth.se/sound/"
    
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
    
    func parse(text: String) throws -> [LexinServiceResultItem] {
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
                                           phonetic: parsePhonetic(phonetic: (try? element.selectText(root + "Phonetic")) ?? ""),
                    inflection: try? element.selectTexts(root + "Inflection"),
                    grammar: try? element.selectText(root + "Graminfo"),
                    example: try? element.selectLexinServiceResultItems(root + "Example"),
                    idiom: try? element.selectLexinServiceResultItems(root + "Idiom"),
                    compound: try? element.selectLexinServiceResultItems(root + "Compound"),
                    translation: try? element.selectText(root + "Translation"),
                    reference: try? parseReference(root: root, element: element),
                    synonym: try? element.selectTexts(root + "Synonym"),
                    soundUrl: try? parseSoundUrl(root: root, element: element))
    }
    
    fileprivate static func parseReference(root: String, element: HtmlParserElement) throws -> String? {
        let reference = try? element.selectElements(root + "Reference").first
        if let type = try reference?.attribute("Type"),
            (!type.isEmpty && type.removeQuotes() != "see") {
            return ""
        }
        return try? reference?.attribute("Value").removeQuotes()
    }
    
    fileprivate static func parseSoundUrl(root: String, element: HtmlParserElement) throws -> String? {
        let phonetic = try? element.selectElements(root + "Phonetic").first
        if let res = try? phonetic?.attribute("File").removeQuotes() {
            return SOUND_URL + res.replaceNonAscii()
        }
        return nil
    }
    
    private static func parseMeaning(root: String, element: HtmlParserElement) throws -> String? {
        var meaning = try? element.selectText(root + "Meaning")
        meaning = (meaning == "") ? (try? element.selectTexts(root + "Definition").first) : meaning
        meaning = (meaning == "") ? (try? element.selectTexts(root + "Gramcom").first) : meaning
        return meaning
    }
}

class LexinServiceParserSwedish : LexinServiceParserDefault {
    override func parse(text: String) throws -> [LexinServiceResultItem] {
        return try htmlParser.parse(html: text.replacingOccurrences(of: "\\n", with: ""), query: "Lemma")
            .map { word ->LexinServiceResultItem in
            let value = (try word.attribute("Value")).removeQuotes()
            let type = (try word.attribute("Type")).removeQuotes()
            let lexems = try LexinServiceParserSwedish.parseLexems(id: "Lexeme", element: word)
            return LexinServiceResultItem(word: value, type: type, baseLang: nil, targetLang: nil, lexemes: lexems)
        }
    }
    
    private static func parseLexems(id: String, element: HtmlParserElement) throws -> [LexinServiceResultItem.Lang] {
        let phonetic = parsePhonetic(phonetic: try element.selectText("Phonetic"))
        var soundUrl: String? = nil
        if let phoneticElement = try element.selectElements("Phonetic").first {
            soundUrl = try parseSoundUrl(root: "", element: phoneticElement)
        }
        let inflection = try element.selectTexts("Inflection")
        var langs: [LexinServiceResultItem.Lang] = try element.selectElements(id).map {
            var lang = try parseLang(root: "", element: $0)
            lang.phonetic = phonetic
            lang.inflection = inflection
            lang.soundUrl = soundUrl
            return lang
        }
        if langs.isEmpty {
            let reference = try? parseReference(root: "", element: element)
            langs.append(LexinServiceResultItem.Lang(meaning: nil, phonetic: phonetic, inflection: inflection, grammar: nil, example: nil, idiom: nil, compound: nil, translation: nil, reference: reference, synonym: nil, soundUrl: soundUrl))
        }
        return langs
    }
}

private extension HtmlParserElement {
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

private extension String {
    func removeQuotes() -> String {
        return self.replacingOccurrences(of: "\\\"", with: "")
    }
    
    func replaceNonAscii() -> String {
        return self.replacingOccurrences(of: "ä", with: "0344")
            .replacingOccurrences(of: "Ä", with: "0344")
    }
}

// Folkets Lexikon
class LexinServiceParserFolkets : ProtocolLexinServiceParser {
    private static let URL = "https://folkets-lexikon.csc.kth.se/folkets/folkets/"
    private static let SOUND_URL = "https://lexin.nada.kth.se/sound/"
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
    
    func parse(text: String) throws -> [LexinServiceResultItem] {
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
    
    private static func parseType(type: String) -> String {
        return wordTypes[type] ?? type
    }
    
    private static func parseLang(element: HtmlParserElement) throws -> LexinServiceResultItem.Lang {
        let lang = LexinServiceResultItem.Lang(meaning: try? element.selectValue("definition"),
                                               phonetic: parsePhonetic(phonetic: (try? element.selectValue("phonetic")) ?? ""),
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
    
    private static func parseTranslatedLang(element: HtmlParserElement) throws -> LexinServiceResultItem.Lang {
        let example = try element.selectElements("example")
            .map { LexinServiceResultItem.Item(id: try $0.attribute("id"), value: (try $0.selectValue("translation") ?? "")) }
        let lang = LexinServiceResultItem.Lang(meaning: nil, phonetic: nil, inflection: nil, grammar: nil, example: example, idiom: nil, compound: nil, translation: nil, reference: nil, synonym: nil, soundUrl: nil)
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

private func parsePhonetic(phonetic: String) -> String {
    if phonetic.isEmpty {
        return ""
    }
    
    let symbols = [ ("+", "‿"),
                    ("@", "ng"),
                    ("$", "sj"),
                    ("2", "²") ]
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
