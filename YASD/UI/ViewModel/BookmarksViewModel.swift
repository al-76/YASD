//
//  BookmarksViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 23.12.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import RxCocoa

class BookmarksViewModel: ViewModel {
    private let bookmarks: AnyStorageRepository<FormattedWord>
    private let player: PlayerManager
    private let spotlight: ExternalCacheService // TODO: It needs to move from domain, probably
    
    struct Input {
        let search: Driver<String>
        let playUrl: Driver<String>
        let removeBookmark: Driver<Int>
        let restore: Driver<String>
    }
    
    struct Output {
        let played: Driver<PlayerManagerResult>
        let bookmarks: Driver<Bookmarks>
        let restored: Driver<String>
    }
    
    init(bookmarks: AnyStorageRepository<FormattedWord>, player: PlayerManager, spotlight: ExternalCacheService) {
        self.bookmarks = bookmarks
        self.player = player
        self.spotlight = spotlight
    }
    
    func transform(from input: Input) -> Output {
        let restored = input.restore.map { [weak self] id -> String in
            guard let self = self else { return "" }
            return self.spotlight.getTitle(from: id)
        }
        let searched = Driver.merge(input.search, restored).flatMapLatest { [weak self] word -> Driver<Bookmarks> in
            guard let self = self else { return Driver.just(.success([])) }
            return self.getBookmarks(with: word)
        }
        let played = input.playUrl.flatMapLatest { [weak self] url -> Driver<PlayerManagerResult> in
            guard let self = self else { return Driver.just(.success(false)) }
            return self.player.playSound(with: url)
                .asDriver { Driver.just(.failure($0)) }
        }
        let removed = input.removeBookmark.filter { $0 >= 0 }.flatMap { [weak self] index -> Driver<StorageServiceResult> in
            guard let self = self else { return Driver.just(.success(false)) }
            return self.removeBookmark(at: index)
        }
        .map { _ in Void() }
        let changedBookmarks = bookmarks.getChangedSubject().asDriver(onErrorJustReturn: false)
            .filter { $0 }
            .map { _ in Void() }
        let updated = Driver.merge(removed, changedBookmarks)
            .flatMap { [weak self] _ -> Driver<Bookmarks> in
                guard let self = self else { return Driver.just(.success([])) }
                return self.getBookmarks(with: "")
            }
            .distinctUntilChanged()
            .flatMap { [weak self] result -> Driver<Bookmarks> in
            guard let self = self else { return Driver.just(.success([])) }
            return self.indexSpotlight(result)
        }
        return Output(played: played,
                      bookmarks: Driver.merge(searched, updated),
                      restored: restored)
    }
    
    private func getBookmarks(with word: String) -> Driver<Bookmarks> {
        return bookmarks.get(with: word)
            .asDriver { Driver.just(.failure($0)) }
    }
    
    private func removeBookmark(at index: Int) -> Driver<StorageServiceResult> {
        return bookmarks.remove(at: index)
            .asDriver { Driver.just(.failure($0)) }
    }
    
    private func indexSpotlight(_ result: Result<[FormattedWord]>) -> Driver<Result<[FormattedWord]>> {
        switch result {
        case let .success(words):
            return spotlight.index(data: words)
                .map { _ in result }
                .asDriver { Driver.just(.failure($0)) }
        case let .failure(error):
            return Driver.just(.failure(error))
        }
    }
}

private extension StorageRepository where T == FormattedWord {
    func get(with word: String) -> Observable<Result<[FormattedWord]>> {
        return get(where: { $0.header.lowercased().starts(with: word.lowercased()) })
    }
}
