//
//  WordsTableViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 14/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import RxCocoa

class WordsViewModel: ViewModel {
    private let words: WordsService
    private let player: PlayerManager
    private let bookmarks: StorageService<FormattedWord>
    
    struct Input {
        let search: Driver<String>
        let playUrl: Driver<String>
        let addBookmark: Driver<FormattedWord>
        let removeBookmark: Driver<FormattedWord>
    }
    
    struct Output {
        let foundWords: Driver<FoundWordResult>
        let played: Driver<PlayerServiceResult>
        let bookmarked: Driver<StorageServiceResult>
        let loading: Driver<Bool>
    }
    
    init(words: WordsService, player: PlayerManager, bookmarks: StorageService<FormattedWord>) {
        self.words = words
        self.player = player
        self.bookmarks = bookmarks
    }
    
    func transform(from input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let changedLanguage = words.language()
            .asDriver(onErrorJustReturn: ParametersStorage.defaultLanguage)
            .withLatestFrom(input.search) { $1 }
        let changedBookmarks = bookmarks.changed.asDriver(onErrorJustReturn: false).filter { $0 }
            .withLatestFrom(input.search) { $1 }
        let search = Driver.merge(input.search, changedLanguage, changedBookmarks)
        let found = search.flatMapLatest { [weak self] word -> Driver<FoundWordResult> in
            guard let self = self else { return Driver.just(.success([])) }
            return self.words.search(word)
                .trackActivity(activityIndicator)
                .asDriver { Driver.just(.failure($0)) }
        }
        let played = input.playUrl
            .flatMapLatest { [weak self] url -> Driver<PlayerServiceResult> in
                guard let self = self else { return Driver.just(.success(false)) }
                return self.player.playSound(with: url)
                    .asDriver { Driver.just(.failure($0)) }
        }
        let addedBookmark = input.addBookmark.flatMap { [weak self] word -> Driver<StorageServiceResult> in
            guard let self = self else { return Driver.just(.success(false)) }
            return self.bookmarks.add(word)
                .asDriver { Driver.just(.failure($0)) }
        }
        let removedBookmark = input.removeBookmark.flatMap { [weak self] word -> Driver<StorageServiceResult> in
            guard let self = self else { return Driver.just(.success(false)) }
            return self.bookmarks.remove(word)
                .asDriver { Driver.just(.failure($0)) }
        }
        return Output(foundWords: found,
                      played: played,
                      bookmarked: Driver.merge(addedBookmark, removedBookmark),
                      loading: activityIndicator.asDriver())
    }
}
