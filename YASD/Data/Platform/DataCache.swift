//
//  DataCache.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import RxSwift

typealias DataCacheResult = Result<Data>
typealias DataCacheOptResult = Result<Data?>
typealias DataCacheBoolResult = Result<Bool>

protocol DataCache {
    func save(_ data: Data, forKey key: String) -> Observable<DataCacheResult>
    func load(_ key: String) -> Observable<DataCacheOptResult>
    func getSize() -> Observable<Int>
    func clear() -> Observable<DataCacheBoolResult>
}
