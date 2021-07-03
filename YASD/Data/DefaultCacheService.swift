//
//  CacheService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 01/10/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import RxSwift

class DefaultCacheService: CacheService {
    let cache: DataCache
    
    init(cache: DataCache) {
        self.cache = cache
    }
    
    func run(_ action: @escaping CachableAction, forKey key: String) -> Observable<CacheServiceResult> {
        return cache.load(key).flatMap { [weak self] result -> Observable<CacheServiceResult> in
            guard let self = self else { return .just(.success(Data())) }
            switch result {
            case .success(let optData):
                if let data = optData { // return cached data
                    return Observable.just(.success(data))
                }
                return self.runAction(action, forKey: key) // run action and cache the data
            case .failure(let error):
                return Observable.just(.failure(error))
            }
        }
    }
    
    func clear() -> Observable<CacheServiceBoolResult> {
        return cache.clear()
    }
    
    func getSize() -> Observable<Int> {
        return cache.getSize()
    }
    
    private func save(_ data: Data, forKey key: String) -> Observable<CacheServiceResult> {
        return cache.save(data, forKey: key)
    }
    
    private func runAction(_ action: CachableAction, forKey key: String) -> Observable<CacheServiceResult> {
        return action().flatMap { [weak self] result -> Observable<CacheServiceResult> in
            guard let self = self else { return Observable.just(result) }
            switch result {
            case .success(let data):
                return self.save(data, forKey: key)
            case .failure(let error):
                return Observable.just(.failure(error))
            }
        }
    }
}
