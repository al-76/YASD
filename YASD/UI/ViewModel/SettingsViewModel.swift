//
//  SettingsViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/07/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxCocoa
import RxSwift

class SettingsViewModel: ViewModel {
    private let getLanguage: AnyUseCase<Void, SettingsRepositoryLanguageResult>
    private let getHistorySize: AnyUseCase<Void, String>
    private let getCacheSize: AnyUseCase<Void, String>
    private let getBookmarksSize: AnyUseCase<Void, String>
    private let clearHistory: AnyUseCase<Void, StorageServiceResult>
    private let clearCache: AnyUseCase<Void, CacheServiceBoolResult>
    private let clearBookmarks: AnyUseCase<Void, StorageServiceResult>

    struct Input {
        let clearHistory: Driver<Void>
        let clearCache: Driver<Void>
        let clearBookmarks: Driver<Void>
    }

    struct Output {
        let selectedLanguage: Driver<SettingsRepositoryLanguageResult>
        let historySize: Driver<String>
        let cacheSize: Driver<String>
        let bookmarksSize: Driver<String>
    }

    init(getLanguage: AnyUseCase<Void, SettingsRepositoryLanguageResult>,
         getHistorySize: AnyUseCase<Void, String>,
         getCacheSize: AnyUseCase<Void, String>,
         getBookmarksSize: AnyUseCase<Void, String>,
         clearHistory: AnyUseCase<Void, StorageServiceResult>,
         clearCache: AnyUseCase<Void, CacheServiceBoolResult>,
         clearBookmarks: AnyUseCase<Void, StorageServiceResult>) {
        self.getLanguage = getLanguage
        self.getHistorySize = getHistorySize
        self.getCacheSize = getCacheSize
        self.getBookmarksSize = getBookmarksSize
        self.clearHistory = clearHistory
        self.clearCache = clearCache
        self.clearBookmarks = clearBookmarks
    }

    func transform(from input: Input) -> Output {
        let historySize = getHistorySize.execute(with: ())
            .asDriver(onErrorJustReturn: "")
        let cacheSize = getCacheSize.execute(with: ())
            .asDriver(onErrorJustReturn: "")
        let bookmarksSize = getBookmarksSize.execute(with: ())
            .asDriver(onErrorJustReturn: "")
        let updatedCacheSize = input.clearCache
            .flatMapLatest { [weak self] _ -> Driver<CacheServiceBoolResult> in
                guard let self = self else { return .just(.success(false)) }
                return self.clearCache.execute(with: ()).asDriver { .just(.failure($0)) }
            }
            .flatMap { _ in cacheSize }
        let updatedHistorySize = input.clearHistory
            .flatMapLatest { [weak self] _ -> Driver<StorageServiceResult> in
                guard let self = self else { return .just(.success(false)) }
                return self.clearHistory.execute(with: ()).asDriver { .just(.failure($0)) }
            }
            .flatMap { _ in historySize }
        let updatedBookmarksSize = input.clearBookmarks
            .flatMapLatest { [weak self] _ -> Driver<StorageServiceResult> in
                guard let self = self else { return .just(.success(false)) }
                return self.clearBookmarks.execute(with: ()).asDriver { .just(.failure($0)) }
            }
            .flatMap { _ in bookmarksSize }
        return Output(selectedLanguage: getLanguage.execute(with: ())
            .asDriver { .just(.failure($0)) },
            historySize: Driver.merge(historySize, updatedHistorySize),
            cacheSize: Driver.merge(cacheSize, updatedCacheSize),
            bookmarksSize: Driver.merge(bookmarksSize, updatedBookmarksSize))
    }
}
