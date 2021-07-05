//
//  GetCacheSizeUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class GetCacheSizeUseCase: UseCase {
    typealias Input = Void
    typealias Output = String

    private let cache: CacheService

    init(cache: CacheService) {
        self.cache = cache
    }

    func execute(with _: Void) -> Observable<String> {
        return cache.getSize().map { value in
            ByteCountFormatter.string(fromByteCount: Int64(value),
                                      countStyle: .file)
        }
    }
}
