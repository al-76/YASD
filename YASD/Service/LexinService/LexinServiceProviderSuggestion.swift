//
//  LexinServiceProviderSuggestion.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15.10.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit

protocol LexinServiceSuggestionParser {
    func getUrl() -> String
    func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)
    func parse(text: String) throws -> [LexinServiceSuggestionResultItem]
}

extension LexinServiceSuggestionParser {
    func parse(text: String) throws -> [LexinServiceSuggestionResultItem] {
        let index = text.firstIndex(of: "\"") ?? text.startIndex
        let res = text[index...]
            .replacingOccurrences(of: "],0,7]", with: "")
            .components(separatedBy: ",")
            .filter { !($0.contains("com.google.gwt") ||
                $0.contains("java.util.ArrayList") ||
                $0.contains("se.jojoman.lexin") ||
                $0.contains("<")) }
            .map { $0.replacingOccurrences(of: "\"", with: "") }
        return res
    }
}

// Default Lexin
class LexinSuggestionParserDefault : LexinServiceSuggestionParser {
    private static let URL = "https://lexin.nada.kth.se/lexin/lexin/"

    func getUrl() -> String {
        return LexinSuggestionParserDefault.URL + "generatecompletion"
    }

    func getRequestParameters(word: String, parameters: String) -> (String?, [String : String]?) {
        let body = "7|0|8|" + LexinSuggestionParserDefault.URL +  "|CA6A42B3B5F751C0CF9E859210723485|se.jojoman.lexin.lexingwt.client.CompletionService|getSuggestions|se.jojoman.lexin.lexingwt.client.CompletionRequest/881062947|" + parameters +  "|com.google.gwt.user.client.ui.SuggestOracle$Request/3707347745|" + word.lowercased() + "|1|2|3|4|1|5|5|6|0|7|5|8|"
        let headers = [ "Content-Type": "text/x-gwt-rpc;charset=UTF-8",
                        "X-GWT-Module-Base": LexinSuggestionParserDefault.URL,
                        "X-GWT-Permutation": "40C84AD510047132F939801CA3CEBA81" ]
        return (body, headers)
    }
}

class LexinSuggestionParserFolkets : LexinServiceSuggestionParser {
    private static let URL = "https://folkets-lexikon.csc.kth.se/folkets/folkets/"

    func getUrl() -> String {
        return LexinSuggestionParserFolkets.URL + "generatecompletion"
    }
    
    func getRequestParameters(word: String, parameters: String) -> (String?, [String : String]?) {
        let body = "7|0|7|" + LexinSuggestionParserFolkets.URL + "|72408650102EFF3C0092D16FF6C6E52F|se.algoritmica.folkets.client.ItemSuggestService|getSuggestions|se.algoritmica.folkets.client.ProposalRequest/3613917143|com.google.gwt.user.client.ui.SuggestOracle$Request/3707347745|" + word.lowercased() + "|1|2|3|4|1|5|5|0|6|5|7|"
        
        let headers = [ "Content-Type": "text/x-gwt-rpc;charset=UTF-8",
                        "X-GWT-Module-Base": LexinSuggestionParserFolkets.URL,
                        "X-GWT-Permutation": "4D1B9CF6325020F77FB7233CD72CF011" ]
        return (body, headers)
    }
}
