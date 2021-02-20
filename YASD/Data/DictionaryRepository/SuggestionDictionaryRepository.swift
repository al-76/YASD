//
//  SuggestionDictionaryRepository.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 20.02.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import RxSwift

class SuggestionDictionaryRepository: DictionaryRepository {
    typealias T = SuggestionResult
    
    private let provider: LexinApiProvider
    
    init(provider: LexinApiProvider) {
        self.provider = provider
    }
    
    func search(_ word: String, _ parameters: ParametersStorage) -> Observable<SuggestionResult> {
        return provider.getApi(by: parameters.getLanguage())
            .suggestion(word, with: parameters.getLanguageString())
    }
}

