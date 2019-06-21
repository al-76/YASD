//
//  LexinService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit
import RxSwift

class LexinServiceParameters {
    let from: String
    let to: String
    
    init(from: String, to: String) {
        self.from = from
        self.to = to
    }
    
    func get() -> String {
        return from + "_" + to
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
    }
    
    var word: String
    var type: String?
    var baseLang: Lang
    var targetLang: Lang?
}

class LexinService {
    public static let URL: String = "https://lexin.nada.kth.se/lexin/lexin/"

    public let formatter: LexinServiceFormatter
    
    private let network: Network
    private let htmlParser: HtmlParser
    private let parameters: LexinServiceParameters
    
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
        return try htmlParser.parse(html: text, query: "Word").map { word in
            let baseLang = try LexinServiceResultItem.parseLang(root: "BaseLang > ", element: word)
            let targetLang = try LexinServiceResultItem.parseLang(root: "TargetLang > ", element: word)
            let value = (try word.attribute("Value")).removeQuotes()
            let type = (try word.attribute("Type")).removeQuotes()
            return LexinServiceResultItem(word: value,
                                          type: type,
                                          baseLang: baseLang,
                                          targetLang: targetLang)
        }
    }
}

extension LexinServiceResultItem {
    fileprivate static func parseLang(root: String, element: HtmlParserElement) throws -> Lang {
        return Lang(meaning: try? element.selectText(root + "Meaning"),
                    phonetic: try? element.selectText(root + "Phonetic"),
                    inflection: try? element.selectTexts(root + "Inflection"),
                    grammar: try? element.selectText(root + "Graminfo"),
                    example: try? element.selectLexinServiceResultItems(root + "Example"),
                    idiom: try? element.selectLexinServiceResultItems(root + "Idiom"),
                    compound: try? element.selectLexinServiceResultItems(root + "Compound"),
                    translation: try? element.selectText(root + "Translation"))
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
