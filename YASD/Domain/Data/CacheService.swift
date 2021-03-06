//
//  CacheService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 01.07.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

typealias CacheServiceResult = Result<Data>
typealias CacheServiceBoolResult = Result<Bool>
typealias CachableAction = () -> Observable<CacheServiceResult>

protocol CacheService {
    func run(_ action: @escaping CachableAction, forKey key: String) -> Observable<CacheServiceResult>
    func clear() -> Observable<CacheServiceBoolResult>
    func getSize() -> Observable<Int>
}
