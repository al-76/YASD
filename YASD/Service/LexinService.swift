//
//  LexinService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LexinServiceParameters {
    public static let supportedLanguages = [
        Language(name: "albanska", code: "alb"),
        Language(name: "amhariska", code: "amh"),
        Language(name: "arabiska", code: "ara"),
        Language(name: "azerbajdzjanska", code: "azj"),
        Language(name: "bosniska", code: "bos"),
        Language(name: "engelska", code: "eng"),
        Language(name: "finska", code: "fin"),
        Language(name: "grekiska", code: "gre"),
        Language(name: "kroatiska", code: "hrv"),
        Language(name: "nordkurdiska", code: "kmr"),
        Language(name: "pashto", code: "pus"),
        Language(name: "persiska", code: "per"),
        Language(name: "ryska", code: "rus"),
        Language(name: "serbiska (latinskt)", code: "srp"),
        Language(name: "serbiska (kyrilliskt)", code: "srp_cyrillic"),
        Language(name: "somaliska", code: "som"),
        Language(name: "spanska", code: "spa"),
        Language(name: "svenska", code: "swe"),
        Language(name: "sydkurdiska", code: "sdh"),
        Language(name: "tigrisnka", code: "tir"),
        Language(name: "turkiska", code: "tur")
    ]
    public static let defaultLanguage = LexinServiceParameters.supportedLanguages[17]
    
    struct Language {
        var name: String
        var code: String
    }
    
    public let language: BehaviorRelay<Language>
    
    init(language: Language) {
        self.language = BehaviorRelay<Language>(value: language)
    }
    
    func get() -> String {
        return "swe" + "_" + getLanguageCode()
    }
    
    func getLanguageCode() -> String {
        return language.value.code
    }
}

extension LexinServiceParameters.Language: Equatable {
    static public func == (lhs: LexinServiceParameters.Language, rhs: LexinServiceParameters.Language) -> Bool {
        return (lhs.name == rhs.name && lhs.code == rhs.code)
    }
}

typealias LexinServiceResult = Result<[LexinServiceResultItem]>

struct LexinServiceResultItem {
    struct Item {
        var id: String
        var value: String
    }
    struct Lang {
        var meaning: String?
        var phonetic: String?
        var inflection: [String?]?
        var grammar: String?
        var example: [Item]?
        var idiom: [Item]?
        var compound: [Item]?
        var translation: String?
        var reference: String?
        var synonym: String?
    }
    
    var word: String
    var type: String?
    var baseLang: Lang?
    var targetLang: Lang?
    var lexemes: [Lang]?
}

class LexinService {
    public static let URL: String = "https://lexin.nada.kth.se/lexin/lexin/"

    public let formatter: LexinServiceFormatter
    public let parameters: LexinServiceParameters
    
    private let network: Network
    private let htmlParser: HtmlParser
    
    init(network: Network, htmlParser: HtmlParser, parameters: LexinServiceParameters, formatter: LexinServiceFormatter) {
        self.network = network
        self.htmlParser = htmlParser
        self.parameters = parameters
        self.formatter = formatter
    }
    
    func search(word: String) -> Observable<LexinServiceResult> {
        if word.isEmpty {
            return Observable<LexinServiceResult>.just(.success([]))
        }
        return network.postRequest(url: LexinService.URL + "lookupword",
                                   parameters: createRequestParameters(word: word))
            .map { [weak self] data in
                do {
                    return .success(try self?.parseHtml(text: data) ?? [])
                } catch let error {
                    return .failure(error)
                }
            }
    }
    
    fileprivate func createRequestParameters(word: String) -> (String?, [String: String]?) {
        let body = "7|0|7|" + LexinService.URL + "|FCDCCA88916BAACF8B03FB48D294BA89|se.jojoman.lexin.lexingwt.client.LookUpService|lookUpWord|se.jojoman.lexin.lexingwt.client.LookUpRequest/682723451|" +
            parameters.get() + "|" +
            word + "|1|2|3|4|1|5|5|1|6|0|7|"
        let headers = [ "Content-Type": "text/x-gwt-rpc;charset=UTF-8",
                        "X-GWT-Module-Base": LexinService.URL,
                        "X-GWT-Permutation": "28B9DF7353B58D7F508C74030B83DEAE" ]
        return (body, headers)
    }
    
    fileprivate func parseHtml(text: String) throws -> [LexinServiceResultItem] {
        let items = try htmlParser.parse(html: text, query: "Word")
        if !items.isEmpty {
            return try items.map { word -> LexinServiceResultItem in
                let baseLang = try LexinServiceResultItem.parseLang(root: "BaseLang > ", element: word)
                let targetLang = try LexinServiceResultItem.parseLang(root: "TargetLang > ", element: word)
                let value = (try word.attribute("Value")).removeQuotes()
                let type = (try word.attribute("Type")).removeQuotes()
                return LexinServiceResultItem(word: value,
                                          type: type,
                                          baseLang: baseLang,
                                          targetLang: targetLang,
                                          lexemes: nil)
            }
        }
        return try htmlParser.parse(html: text, query: "Lemma").map { word ->LexinServiceResultItem in
            let value = (try word.attribute("Value")).removeQuotes()
            let type = (try word.attribute("Type")).removeQuotes()
            let lexems = try LexinServiceResultItem.parseLangs(id: "Lexeme",element: word)
            return LexinServiceResultItem(word: value, type: type, baseLang:nil, targetLang: nil, lexemes: lexems)
        }
    }
}

extension LexinServiceResultItem {
    fileprivate static func parseLang(root: String, element: HtmlParserElement) throws -> Lang {
        return Lang(meaning: try parseMeaning(root: root, element: element),
                    phonetic: try? element.selectText(root + "Phonetic"),
                    inflection: try? element.selectTexts(root + "Inflection"),
                    grammar: try? element.selectText(root + "Graminfo"),
                    example: try? element.selectLexinServiceResultItems(root + "Example"),
                    idiom: try? element.selectLexinServiceResultItems(root + "Idiom"),
                    compound: try? element.selectLexinServiceResultItems(root + "Compound"),
                    translation: try? element.selectText(root + "Translation"),
                    reference: try? parseReference(root: root, element: element),
                    synonym: try? element.selectText(root + "Synonym"))
    }
    
    fileprivate static func parseLangs(id: String, element: HtmlParserElement) throws -> [Lang] {
        let phonetic = try element.selectText("Phonetic")
        var langs: [Lang] = try element.selectElements(id).map {
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

extension HtmlParserElement {
    func selectLexinServiceResultItems(_ query: String) throws -> [LexinServiceResultItem.Item] {
        return try selectElements(query).map { element in LexinServiceResultItem.Item(id: try element.attribute("ID"),
                                                                                      value: try element.text()) }
    }
}

extension String {
    func removeQuotes() -> String {
        return self.replacingOccurrences(of: "\\\"", with: "")
    }
}
