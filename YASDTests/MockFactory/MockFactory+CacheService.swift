//
//  MockFactory+CacheService.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 02.07.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import RxSwift
import Cuckoo

extension MockFactory {
    static func createMockCacheService(_ testSize: Int) -> MockCacheService {
        let mock = MockCacheService()
        stub(mock) { stub in
            when(stub.getSize()).thenReturn(.just(testSize))
            when(stub.clear()).thenReturn(.just(true))
        }
        return mock
    }
}
