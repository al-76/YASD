//
//  CacheService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 01/10/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import RxSwift

typealias CacheServiceResult = Result<Data>
typealias CachableAction = () -> Observable<CacheServiceResult>

class CacheService {
    let cache: DataCache
    
    init(cache: DataCache) {
        self.cache = cache
    }
    
    func run(_ action: @escaping CachableAction, forKey key: String) -> Observable<CacheServiceResult> {
        return cache.load(key).flatMap { [weak self] data -> Observable<CacheServiceResult> in
            if data == nil {
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
            return Observable.just(.success(data!))
        }
    }
    
    func save(_ data: Data, forKey key: String) -> Observable<CacheServiceResult> {
        return cache.save(data, forKey: key).map { .success($0) }
    }
}
