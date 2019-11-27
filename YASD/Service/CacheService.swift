//
//  CacheService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 01/10/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import RxSwift

typealias CachebleActionResult = Result<Bool>
typealias CachableAction = () -> Observable<Data>

class CacheService {
    let cache: DataCache
    
    init(cache: DataCache) {
        self.cache = cache
    }
    
    func run(_ action: @escaping CachableAction, forKey key: String) -> Observable<Data> {
        return cache.load(key).flatMap { [weak self] data -> Observable<Data> in
            if data == nil {
                return action().flatMap { [weak self] data -> Observable<Data> in
                    guard let self = self else { return Observable.just(data) }
                    return self.cache.save(data, forKey: key)
                }
            }
            return Observable.just(data!)
        }
    }
}
