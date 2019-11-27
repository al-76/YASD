//
//  LexinService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import Foundation

class LexinService {
    private let parameters: ParametersStorage
    private let provider: LexinApiProvider

    init(parameters: ParametersStorage, provider: LexinApiProvider) {
        self.parameters = parameters
        self.provider = provider
    }

    func search(word: String) -> Observable<LexinWordResult> {
        return provider.getApi(language: parameters.getLanguage())
            .search(word: word, language: parameters.getLanguageString())
    }
    
    func suggestion(word: String) -> Observable<SuggestionResult> {
        return provider.getApi(language: parameters.getLanguage())
            .suggestion(word: word, language: parameters.getLanguageString())
    }
    
    func language() -> BehaviorSubject<Language> {
        return parameters.language
    }
}
