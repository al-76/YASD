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
    private let lexin: LexinService
    private let formatter: LexinServiceFormatter
    private let player: PlayerService
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
    }
    
    init(lexin: LexinService, formatter: LexinServiceFormatter, player: PlayerService, bookmarks: StorageService<FormattedWord>) {
        self.lexin = lexin
        self.formatter = formatter
        self.player = player
        self.bookmarks = bookmarks
    }
    
    func transform(from input: Input) -> Output {
        let changedLanguage = lexin.language()
            .asDriver(onErrorJustReturn: ParametersStorage.defaultLanguage)
            .withLatestFrom(input.search) { $1 }
        let changedBookmarks = bookmarks.changed.asDriver(onErrorJustReturn: false).filter { $0 }
            .withLatestFrom(input.search) { $1 }
        let found = Driver.merge(input.search, changedLanguage, changedBookmarks)
            .flatMapLatest { [weak self] word -> Driver<FormattedWordResult> in
                guard let self = self else { return Driver.just(.success([])) }
                return self.searchWord(word)
        }
        .flatMap { [weak self] word -> Driver<FoundWordResult> in
            guard let self = self else { return Driver.just(.success([])) }
            return self.checkBookmarked(word)
        }
        let played = input.playUrl
            .flatMapLatest { [weak self] url -> Driver<PlayerServiceResult> in
                guard let self = self else { return Driver.just(.success(false)) }
                return self.player.playSound(with: url)
                    .asDriver { Driver.just(.failure($0)) }
        }
        let addedBookmark = input.addBookmark.flatMap { [weak self] word -> Driver<StorageServiceResult> in
            guard let self = self else { return Driver.just(.success(false)) }
            return self.bookmarks.add(word).asDriver { Driver.just(.failure($0)) }
        }
        let removedBookmark = input.removeBookmark.flatMap { [weak self] word -> Driver<StorageServiceResult> in
            guard let self = self else { return Driver.just(.success(false)) }
            return self.bookmarks.remove(word).asDriver { Driver.just(.failure($0)) }
        }
        return Output(foundWords: found, played: played, bookmarked: Driver.merge(addedBookmark, removedBookmark))
    }
    
    private func searchWord(_ word: String) -> Driver<FormattedWordResult> {
        return lexin.search(word)
            .map { [weak self] result in
                guard let self = self else { return .success([]) }
                return self.formatter.format(result: result) }
            .asDriver { Driver.just(.failure($0)) }
    }
    
    private func checkBookmarked(_ words: FormattedWordResult) -> Driver<FoundWordResult> {
        switch words {
        case let .success(res):
            return Observable.from(res.map { bookmarks.contains($0) }).merge().toArray()
                .map { bookmarked in
                    return zip(res, bookmarked)
                        .map { (word: $0, bookmarked: $1.handleResult(false, nil)) }
            }
            .map { .success($0) }
            .asDriver(onErrorJustReturn: .success([]))
        case let .failure(error):
            return Driver.just(.failure(error))
        }
    }
}
