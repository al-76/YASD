//
//  MockFactory+ExternalCacheService.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 29.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import RxSwift
import Cuckoo

extension MockFactory {
    static func createMockExternalCacheService(_ testValue: String) -> MockExternalCacheService {
        let mock = MockExternalCacheService()
        stub(mock) { stub in
            when(stub.getTitle(from: any())).then { _ in
                return testValue
            }
            when(stub.index(data: any())).thenReturn(.just(.success(())))
        }
        return mock
    }
}
