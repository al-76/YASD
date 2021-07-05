//
//  WordsTableViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 14/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxCocoa
import RxSwift

class WordsViewModel: ViewModel {
    private let searchWord: AnyUseCase<SearchWordUseCase.Input, FoundWordResult>
    private let addBookmark: AnyUseCase<FormattedWord, StorageServiceResult>
    private let playSound: AnyUseCase<String, PlayerManagerResult>
    private let removeBookmark: AnyUseCase<FormattedWord, StorageServiceResult>

    struct Input {
        let search: Driver<String>
        let playUrl: Driver<String>
        let addBookmark: Driver<FormattedWord>
        let removeBookmark: Driver<FormattedWord>
    }

    struct Output {
        let foundWords: Driver<FoundWordResult>
        let played: Driver<PlayerManagerResult>
        let bookmarked: Driver<StorageServiceResult>
        let loading: Driver<Bool>
    }

    init(searchWord: AnyUseCase<SearchWordUseCase.Input, FoundWordResult>,
         addBookmark: AnyUseCase<FormattedWord, StorageServiceResult>,
         playSound: AnyUseCase<String, PlayerManagerResult>,
         removeBookmark: AnyUseCase<FormattedWord, StorageServiceResult>) {
        self.searchWord = searchWord
        self.addBookmark = addBookmark
        self.playSound = playSound
        self.removeBookmark = removeBookmark
    }

    func transform(from input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let found = input.search.flatMapLatest { [weak self] word -> Driver<FoundWordResult> in
            guard let self = self else { return .just(.success([])) }
            return self.searchWord.execute(with: (word, activityIndicator))
                .asDriver { Driver.just(.failure($0)) }
        }
        let played = input.playUrl
            .flatMapLatest { [weak self] url -> Driver<PlayerManagerResult> in
                guard let self = self else { return .just(.success(false)) }
                return self.playSound.execute(with: url)
                    .asDriver { .just(.failure($0)) }
            }
        let addedBookmark = input.addBookmark.flatMap { [weak self] word -> Driver<StorageServiceResult> in
            guard let self = self else { return Driver.just(.success(false)) }
            return self.addBookmark.execute(with: word)
                .asDriver { .just(.failure($0)) }
        }
        let removedBookmark = input.removeBookmark.flatMap { [weak self] word -> Driver<StorageServiceResult> in
            guard let self = self else { return Driver.just(.success(false)) }
            return self.removeBookmark.execute(with: word)
                .asDriver { .just(.failure($0)) }
        }
        return Output(foundWords: found,
                      played: played,
                      bookmarked: Driver.merge(addedBookmark, removedBookmark),
                      loading: activityIndicator.asDriver())
    }
}
