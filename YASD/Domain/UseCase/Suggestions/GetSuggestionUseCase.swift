//
//  GetSuggestionUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 22.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class GetSuggestionUseCase: UseCase {
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
        let foundSuggestions = settings.getLanguage().flatMap { [weak self] language -> Observable<SuggestionResult> in
            guard let self = self else { return .just(.success([])) }
            return self.suggestions.search(word, language)
        }
        return self.history.getSuggestionAndHistory(suggestions: foundSuggestions, word)
    }
}
