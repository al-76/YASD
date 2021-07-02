//
//  BookmarksViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 23.12.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import RxSwiftExt
import RxCocoa

class BookmarksViewModel: ViewModel {
    private let searchBookmark: AnyUseCase<String, Bookmarks>
    private let restoreBookmark: AnyUseCase<String, String>
    private let removeBookmark: AnyUseCase<Int, StorageServiceResult>
    private let changedBookmark: AnyUseCase<Void, Bookmarks>
    private let playSound: AnyUseCase<String, PlayerManagerResult>
    
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
    
    init(searchBookmark: AnyUseCase<String, Bookmarks>,
         restoreBookmark: AnyUseCase<String, String>,
         removeBookmark: AnyUseCase<Int, StorageServiceResult>,
         changedBookmark: AnyUseCase<Void, Bookmarks>,
         playSound: AnyUseCase<String, PlayerManagerResult>) {
        self.searchBookmark = searchBookmark
        self.restoreBookmark = restoreBookmark
        self.removeBookmark = removeBookmark
        self.changedBookmark = changedBookmark
        self.playSound = playSound
    }
    
    func transform(from input: Input) -> Output {
        let restored = input.restore.flatMap { [weak self] id -> Driver<String> in
            guard let self = self else { return .just("") }
            return self.restoreBookmark.execute(with: id)
                .asDriver { _ in .just("") }
        }
        let found = Driver.merge(input.search, restored).flatMap { [weak self] word -> Driver<Bookmarks> in
            guard let self = self else { return .just(.success([])) }
            return self.searchBookmark.execute(with: word)
                .asDriver { .just(.failure($0)) }
        }
        let changed = changedBookmark.execute(with: ())
            .asDriver { .just(.failure($0)) }
        let removed = input.removeBookmark.filter { $0 >= 0 }.flatMap { [weak self] index -> Driver<StorageServiceResult> in
            guard let self = self else { return .just(.success(false)) }
            return self.removeBookmark.execute(with: index)
                .asDriver { .just(.failure($0)) }
        }.flatMap { _ -> Driver<Bookmarks> in
            return changed
        }
        let played = input.playUrl.flatMap { [weak self] url -> Driver<PlayerManagerResult> in
            guard let self = self else { return .just(.success(false)) }
            return self.playSound.execute(with: url)
                .asDriver { .just(.failure($0)) }
        }
        return Output(played: played,
                      bookmarks: Driver.merge(found, removed, changed),
                      restored: restored)
    }
}
