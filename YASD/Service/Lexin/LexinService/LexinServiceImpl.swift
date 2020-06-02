//
//  LexinServiceImpl.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import Foundation

class LexinServiceImpl: LexinService {
    private let parameters: ParametersStorage
    private let provider: LexinApiProvider

    init(parameters: ParametersStorage, provider: LexinApiProvider) {
        self.parameters = parameters
        self.provider = provider
    }

    func search(_ word: String) -> Observable<LexinWordResult> {
        return provider.getApi(by: parameters.getLanguage())
            .search(word, with: parameters.getLanguageString())
    }
    
    func suggestion(_ word: String) -> Observable<SuggestionResult> {
        return provider.getApi(by: parameters.getLanguage())
            .suggestion(word, with: parameters.getLanguageString())
    }
    
    func language() -> BehaviorSubject<Language> {
        return parameters.language
    }
}
