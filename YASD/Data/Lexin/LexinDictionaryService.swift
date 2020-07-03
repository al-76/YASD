//
//  LexinDictionaryService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 04.06.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import RxSwift
import Foundation

class LexinDictionaryService: SuggestionService, WordsService {
    private let parameters: ParametersStorage
    private let provider: LexinApiProvider
    private let mapper: LexinWordMapper

    init(parameters: ParametersStorage, provider: LexinApiProvider, mapper: LexinWordMapper) {
        self.parameters = parameters
        self.provider = provider
        self.mapper = mapper
    }

    func search(_ word: String) -> Observable<FoundWordResult> {
        return provider.getApi(by: parameters.getLanguage())
            .search(word, with: parameters.getLanguageString())
            .flatMap { [weak self] result -> Observable<FoundWordResult> in
                guard let self = self else { return Observable.just(.success([])) }
                return self.mapper.map(input: result)
        }
    }
    
    func search(_ word: String) -> Observable<SuggestionResult> {
        return provider.getApi(by: parameters.getLanguage())
            .suggestion(word, with: parameters.getLanguageString())
    }
    
    func language() -> BehaviorSubject<Language> {
        return parameters.language
    }
}
