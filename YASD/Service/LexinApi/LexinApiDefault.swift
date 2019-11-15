//
//  LexinApiDefault.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift

class LexinApiDefault : LexinApi {
    private let network: NetworkService
    private let parserWords: LexinServiceParser
    private let parserSuggestions: LexinServiceSuggestionParser
    
    init(network: NetworkService, parserWords: LexinServiceParser, parserSuggestions: LexinServiceSuggestionParser) {
        self.network = network
        self.parserWords = parserWords
        self.parserSuggestions = parserSuggestions
    }
    
    func search(word: String, add: String) -> Observable<LexinServiceResult> {
        if word.isEmpty {
            return Observable<LexinServiceResult>.just(.success([]))
        }
        
        let parameters = (url: parserWords.getUrl(),
                          headers: parserWords.getRequestHeaders(word: word, parameters: add))
        return network.postRequest(with: parameters).map { [weak self] result in
            guard let self = self else { return .success([]) }
            do {
                return try .success(self.parserWords.parse(text: result))
            } catch let error {
                return .failure(error)
            }
        }
    }
    
    func suggestion(word: String, add: String) -> Observable<LexinServiceSuggestionResult> {
        if word.isEmpty {
                return Observable.just(.success([]))
        }
        
        let parameters = (url: parserSuggestions.getUrl(),
                          headers: parserSuggestions.getRequestParameters(word: word, parameters: add))
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
