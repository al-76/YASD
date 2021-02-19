//
//  LexinServiceProviderSuggestion.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15.10.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit

protocol LexinParserSuggestion {
    func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters
    func parse(text: String) throws -> [Suggestion]
}

extension LexinParserSuggestion {
    private func filter(_ value: String) -> Bool {
        return !(value.contains("com.google.gwt") ||
                    value.contains("java.util.ArrayList") ||
                    value.contains("se.jojoman.lexin") ||
                    value.contains("se.algoritmica.folkets") ||
                    value.contains("<") ||
                    value.contains("img/flag_") ||
                    value.contains("grafik/flag_"))
    }
    
    internal func parse(text: String) throws -> [Suggestion] {
        let index = text.firstIndex(of: "\"") ?? text.startIndex
        let res = text[index...]
            .replacingOccurrences(of: "],0,7]", with: "")
            .components(separatedBy: ",")
            .filter { filter($0) }
            .map { $0.replacingOccurrences(of: "\"", with: "")
                .trimmingCharacters(in: .whitespacesAndNewlines) }
            .uniques
        return res
    }
}

// Default Lexin
class LexinParserSuggestionDefault : LexinParserSuggestion {
    private static let URL = "https://lexin.nada.kth.se/lexin/lexin/"

    func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters {
        return (url: getUrl(), parameters: getRequestparameters(word, language))
    }

    private func getUrl() -> String {
        return LexinParserSuggestionDefault.URL + "generatecompletion"
    }

    private func getRequestparameters(_ word: String, _ language: String) -> (String?, [String : String]?) {
        let body = "7|0|8|" + LexinParserSuggestionDefault.URL +  "|CA6A42B3B5F751C0CF9E859210723485|se.jojoman.lexin.lexingwt.client.CompletionService|getSuggestions|se.jojoman.lexin.lexingwt.client.CompletionRequest/881062947|" + language +  "|com.google.gwt.user.client.ui.SuggestOracle$Request/3707347745|" + word.lowercased() + "|1|2|3|4|1|5|5|6|0|7|5|8|"
        let parameters = ["Content-Type": "text/x-gwt-rpc;charset=UTF-8",
                        "X-GWT-Module-Base": LexinParserSuggestionDefault.URL,
                        "X-GWT-Permutation": "40C84AD510047132F939801CA3CEBA81"]
        return (body, parameters)
    }
}

class LexinParserSuggestionFolkets : LexinParserSuggestion {
    private static let URL = "https://folkets-lexikon.csc.kth.se/folkets/folkets/"

    func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters {
        return (url: getUrl(), parameters: getRequestparameters(word, language))
    }
    
    private func getUrl() -> String {
        return LexinParserSuggestionFolkets.URL + "generatecompletion"
    }
    
    private func getRequestparameters(_ word: String, _ language: String) -> (String?, [String : String]?) {
        let body = "7|0|7|" + LexinParserSuggestionFolkets.URL + "|72408650102EFF3C0092D16FF6C6E52F|se.algoritmica.folkets.client.ItemSuggestService|getSuggestions|se.algoritmica.folkets.client.ProposalRequest/3613917143|com.google.gwt.user.client.ui.SuggestOracle$Request/3707347745|" + word.lowercased() + "|1|2|3|4|1|5|5|0|6|5|7|"
        
        let parameters = ["Content-Type": "text/x-gwt-rpc;charset=UTF-8",
                        "X-GWT-Module-Base": LexinParserSuggestionFolkets.URL,
                        "X-GWT-Permutation": "4D1B9CF6325020F77FB7233CD72CF011"]
        return (body, parameters)
    }
}

private extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
