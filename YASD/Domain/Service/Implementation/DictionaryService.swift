//
//  DictionaryService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 04.06.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import RxSwift
import Foundation

class DictionaryService: SuggestionService, WordsService {
    private let parameters: ParametersStorage
    private let suggestions: AnyDictionaryRepository<SuggestionResult>
    private let words: AnyDictionaryRepository<FoundWordResult>

    init(parameters: ParametersStorage,
         suggestions: AnyDictionaryRepository<SuggestionResult>,
         words: AnyDictionaryRepository<FoundWordResult>) {
        self.parameters = parameters
        self.suggestions = suggestions
        self.words = words
    }

    func search(_ word: String) -> Observable<FoundWordResult> {
        return words.search(word, parameters)
    }
    
    func search(_ word: String) -> Observable<SuggestionResult> {
        return suggestions.search(word, parameters)
    }
    
    func language() -> BehaviorSubject<Language> {
        return parameters.language
    }
}
