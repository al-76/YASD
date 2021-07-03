//
//  SearchWordUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 22.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class SearchWordUseCase: UseCase {
    typealias Input = (word: String, indicator: ActivityIndicator)
    typealias Output = FoundWordResult
    
    private let words: AnyDictionaryRepository<FoundWordResult>
    private let settings: SettingsRepository
    private let bookmarks: AnyStorageRepository<FormattedWord>
    
    init(words: AnyDictionaryRepository<FoundWordResult>,
         settings: SettingsRepository,
         bookmarks: AnyStorageRepository<FormattedWord>) {
        self.words = words
        self.settings = settings
        self.bookmarks = bookmarks
    }
    
    func execute(with input: Input) -> Observable<FoundWordResult> {
        let word = input.word.lowercased()
        let foundWords = settings.getLanguage().flatMap { [weak self] result -> Observable<FoundWordResult> in
            guard let self = self else { return .just(.success([])) }
            switch(result) {
            case let .success(language):
                return self.words.search(word, language)
            case let .failure(error):
                return .just(.failure(error))
            }
        }.trackActivity(input.indicator)
        let changedBookmarks = bookmarks.getChangedSubject().filter { $0 }
        let changedLanguage = settings.getLanguageBehaviour().map { _ in true }
        let changedState = Observable.merge(changedBookmarks, changedLanguage)
            .flatMap { _ in foundWords }
        return Observable.merge(changedState, foundWords)
    }
}
