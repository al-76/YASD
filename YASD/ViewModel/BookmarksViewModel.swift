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
            return self.bookmarks.get(with: word)
                .asDriver { Driver.just(.failure($0)) }
        }
        let played = input.playUrl.flatMapLatest { [weak self] url -> Driver<PlayerServiceResult> in
            guard let self = self else { return Driver.just(.success(false)) }
            return self.player.playSound(with: url)
                .asDriver { Driver.just(.failure($0)) }
        }
        let removed = input.removeBookmark
            .filter { $0 >= 0 }
            .withLatestFrom(searched) { ($0, $1) }
            .flatMapLatest { [weak self] index, searchedBookmarks -> Driver<StorageServiceResult> in
                guard let self = self else { return Driver.just(.success(false)) }
                let data = searchedBookmarks.handleResult([], nil)
                if index < data.count {
                    return self.bookmarks.remove(data[index])
                        .asDriver { Driver.just(.failure($0)) }
                }
                return Driver.just(.success(false))
            }
            .flatMap { [weak self] _ -> Driver<Bookmarks> in
                guard let self = self else { return Driver.just(.success([])) }
                return self.bookmarks.get(with: "")
                    .asDriver { Driver.just(.failure($0)) }
            }

        return Output(played: played, bookmarks: Driver.merge(searched, removed))
    }
}

private extension StorageService where T == FormattedWord {
    func get(with word: String) -> Observable<Result<[FormattedWord]>> {
        return get(where: { $0.header.starts(with: word) })
    }
}
