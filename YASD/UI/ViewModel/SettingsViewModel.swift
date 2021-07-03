//
//  SettingsViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/07/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import RxCocoa

class SettingsViewModel: ViewModel {
    private let getLanguage: AnyUseCase<Void, String>
    private let getHistorySize: AnyUseCase<Void, String>
    private let getCacheSize: AnyUseCase<Void, String>
    private let clearHistory: AnyUseCase<Void, StorageServiceResult>
    private let clearCache: AnyUseCase<Void, CacheServiceBoolResult>
    
    struct Input {
        let clearHistory: Driver<Void>
        let clearCache: Driver<Void>
    }
    
    struct Output {
        let selectedLanguage: Driver<String>
        let historySize: Driver<String>
        let cacheSize: Driver<String>
    }

    init(getLanguage: AnyUseCase<Void, String>,
         getHistorySize: AnyUseCase<Void, String>,
         getCacheSize: AnyUseCase<Void, String>,
         clearHistory: AnyUseCase<Void, StorageServiceResult>,
         clearCache: AnyUseCase<Void, CacheServiceBoolResult>) {
        self.getLanguage = getLanguage
        self.getHistorySize = getHistorySize
        self.getCacheSize = getCacheSize
        self.clearHistory = clearHistory
        self.clearCache = clearCache
    }
    
    func transform(from input: Input) -> Output {
        let historySize = getHistorySize.execute(with: ())
            .asDriver(onErrorJustReturn: "")
        let cacheSize = getCacheSize.execute(with: ())
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
        return Output(selectedLanguage: getLanguage.execute(with: ())
                        .asDriver(onErrorJustReturn: Language.defaultLanguage.name),
                      historySize: Driver.merge(historySize, updatedHistorySize),
                      cacheSize: Driver.merge(cacheSize, updatedCacheSize))
    }
}
