//
//  MockFactory+ExternalCacheService.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 29.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import Cuckoo
import RxSwift

extension MockFactory {
    static func createMockExternalIndexer(_ testValue: String) -> MockExternalIndexer {
        let mock = MockExternalIndexer()
        stub(mock) { stub in
            when(stub.getTitle(from: any())).then { _ in
                testValue
            }
            when(stub.index(data: any())).thenReturn(.just(.success(())))
        }
        return mock
    }
}
