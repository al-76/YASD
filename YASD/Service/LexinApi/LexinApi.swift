//
//  LexinApi.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift

class LexinApi {
    private let network: NetworkService
    private let parserWords: LexinParserWords
    private let parserSuggestions: LexinParserSuggestion
    
    init(network: NetworkService, parserWords: LexinParserWords, parserSuggestions: LexinParserSuggestion) {
        self.network = network
        self.parserWords = parserWords
        self.parserSuggestions = parserSuggestions
    }
    
    func search(word: String, language: String) -> Observable<LexinWordResult> {
        if word.isEmpty {
            return Observable<LexinWordResult>.just(.success([]))
        }
        
        let parameters = parserWords.getRequestParameters(word: word, language: language)
        return network.postRequest(with: parameters).map { [weak self] result in
            guard let self = self else { return .success([]) }
            do {
                return try .success(self.parserWords.parse(text: result))
            } catch let error {
                return .failure(error)
            }
        }
    }
    
    func suggestion(word: String, language: String) -> Observable<SuggestionResult> {
        if word.isEmpty {
            return Observable.just(.success([]))
        }
        
        let parameters = parserSuggestions.getRequestParameters(word: word, language: language)
        return network.postRequest(with: parameters).map { [weak self] result in
            guard let self = self else { return .success([]) }
            do {
                return try.success(self.parserSuggestions.parse(text: result))
            } catch let error {
                return .failure(error)
            }
        }
    }
}
