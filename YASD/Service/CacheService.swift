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
    
    func runAction(key: String, action: @escaping CachableAction) -> Observable<Data> {
        return cache.load(key).flatMap { [weak self] data -> Observable<Data> in
            if data == nil {
                return action().flatMap { [weak self] data -> Observable<Data> in
                    guard let self = self else { return Observable.just(data) }
                    return self.cache.save(key, forData: data)
                }
            }
            return Observable.just(data!)
        }
    }
}
