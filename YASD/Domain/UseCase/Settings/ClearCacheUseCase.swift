//
//  ClearCacheUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class ClearCacheUseCase: UseCase {
    typealias Input = Void
    typealias Output = CacheServiceBoolResult

    private let cache: CacheService

    init(cache: CacheService) {
        self.cache = cache
    }

    func execute(with _: Void) -> Observable<CacheServiceBoolResult> {
        return cache.clear()
    }
}
