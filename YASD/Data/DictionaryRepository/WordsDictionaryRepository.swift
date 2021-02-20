//
//  WordsDictionaryRepository.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 20.02.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import RxSwift

class WordsDictionaryRepository: DictionaryRepository {
    typealias T = FoundWordResult
    
    private let provider: LexinApiProvider
    private let mapper: LexinWordMapper
    
    init(provider: LexinApiProvider, mapper: LexinWordMapper) {
        self.provider = provider
        self.mapper = mapper
    }
    
    func search(_ word: String, _ parameters: ParametersStorage) -> Observable<FoundWordResult> {
        return provider.getApi(by: parameters.getLanguage())
            .search(word, with: parameters.getLanguageString())
            .flatMap { [weak self] result -> Observable<FoundWordResult> in
                guard let self = self else { return Observable.just(.success([])) }
                return self.mapper.map(input: result) }
    }
}
