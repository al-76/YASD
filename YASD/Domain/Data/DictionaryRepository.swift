//
//  DictionaryRepository.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 20.02.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import RxSwift

protocol DictionaryRepository {
    associatedtype T

    func search(_ word: String, _ language: Language) -> Observable<T>
}

class AnyDictionaryRepository<T>: DictionaryRepository {
    private let searchObject: (String, Language) -> Observable<T>

    init<TypeDictionaryRepository: DictionaryRepository>(wrapped: TypeDictionaryRepository)
        where TypeDictionaryRepository.T == T {
        searchObject = wrapped.search
    }

    func search(_ word: String, _ language: Language) -> Observable<T> {
        return searchObject(word, language)
    }
}
