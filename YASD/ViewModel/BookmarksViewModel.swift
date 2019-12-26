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
    private let bookmarks: StorageService<FormattedWord>
    private let player: PlayerService
    
    struct Input {
        let search: Driver<String>
        let playUrl: Driver<String>
        let removeBookmark: Driver<Int>
    }
    
    struct Output {
        let played: Driver<PlayerServiceResult>
        let bookmarks: Driver<Bookmarks>
    }
    
    init(bookmarks: StorageService<FormattedWord>, player: PlayerService) {
        self.bookmarks = bookmarks
        self.player = player
    }
    
    func transform(from input: Input) -> Output {
        let searched = input.search.flatMapLatest { [weak self] word -> Driver<Bookmarks> in
            guard let self = self else { return Driver.just(.success([])) }
            return self.getBookmarks(with: word)
        }
        let played = input.playUrl.flatMapLatest { [weak self] url -> Driver<PlayerServiceResult> in
            guard let self = self else { return Driver.just(.success(false)) }
            return self.player.playSound(with: url)
                .asDriver { Driver.just(.failure($0)) }
        }
        let removed = input.removeBookmark.filter { $0 >= 0 }.flatMap { [weak self] index -> Driver<StorageServiceResult> in
            guard let self = self else { return Driver.just(.success(false)) }
            return self.removeBookmark(at: index)
        }
        .map { _ in Void() }
        let changedBookmarks = bookmarks.changed.asDriver(onErrorJustReturn: false)
            .filter { $0 }
            .map { _ in Void() }
        let updated = Driver.merge(removed, changedBookmarks)
            .flatMap { [weak self] _ -> Driver<Bookmarks> in
                guard let self = self else { return Driver.just(.success([])) }
                return self.getBookmarks(with: "")
        }
        
        return Output(played: played, bookmarks: Driver.merge(searched, updated))
    }
    
    private func getBookmarks(with word: String) -> Driver<Bookmarks> {
        return bookmarks.get(with: word)
            .asDriver { Driver.just(.failure($0)) }
    }
    
    private func removeBookmark(at index: Int) -> Driver<StorageServiceResult> {
        return bookmarks.remove(at: index)
            .asDriver { Driver.just(.failure($0)) }
    }
}

private extension StorageService where T == FormattedWord {
    func get(with word: String) -> Observable<Result<[FormattedWord]>> {
        return get(where: { $0.header.lowercased().starts(with: word.lowercased()) })
    }
}
