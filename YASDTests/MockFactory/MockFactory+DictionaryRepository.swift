//
//  MockFactory+DictionaryRepository.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 24.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import RxSwift
import Cuckoo

extension MockFactory {
    static func createMockDictionaryRepository() -> MockAnyDictionaryRepository<SuggestionResult> {
        let mock = MockAnyDictionaryRepository<SuggestionResult>(wrapped: MockDictionaryRepository())
        stub(mock) { stub in
            when(stub.search(any(), any())).then { _ in .just(.success([Suggestion("test")])) }
        }
        return mock
    }
}
