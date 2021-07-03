//
//  AddSuggestionUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 22.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class AddSuggestionUseCase: UseCase {
    typealias Input = String
    typealias Output = SuggestionItemResult
    
    private let suggestions: AnyDictionaryRepository<SuggestionResult>
    private let settings: SettingsRepository
    private let history: AnyStorageRepository<Suggestion>
    
    init(suggestions: AnyDictionaryRepository<SuggestionResult>,
         settings: SettingsRepository,
         history: AnyStorageRepository<Suggestion>) {
        self.suggestions = suggestions
        self.settings = settings
        self.history = history
    }
    
    func execute(with input: String) -> Observable<SuggestionItemResult> {
        let word = input.lowercased()
        let foundSuggestions = settings.getLanguage().flatMap { [weak self] result -> Observable<SuggestionResult> in
            guard let self = self else { return .just(.success([])) }
            switch(result) {
            case let .success(language):
                return self.suggestions.search(word, language)
            case let .failure(error):
                return .just(.failure(error))
            }
        }
        return history.add(word)
            .flatMap { [weak self] _ -> Observable<SuggestionItemResult> in
                guard let self = self else { return .just(.success([])) }
                return self.history.getSuggestionAndHistory(suggestions: foundSuggestions, word)
        }
    }
}
