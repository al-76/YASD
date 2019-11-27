//
//  LexinApiProviderTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 22.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

@testable import YASD

import XCTest
import RxSwift
import RxTest
import Cuckoo

class LexinApiProviderTests: XCTestCase {
    func testGetApi() {
        // Arrange
        let defaultApi = createApiStub()
        let englishApi = createApiStub()
        let swedishApi = createApiStub()
        let apiProvider = LexinApiProvider(defaultApi: defaultApi,
                                           folketsApi: englishApi,
                                           swedishApi: swedishApi)
        
        // Act
        var result: [ LexinApi ] = []
        for name in [ "default", "eng", "swe" ] {
            result.append(apiProvider
                .getApi(language: Language(name: name, code: name)))
        }
        
        // Assert
        XCTAssert(result[0] === defaultApi)
        XCTAssert(result[1] === englishApi)
        XCTAssert(result[2] === swedishApi)
    }
    
    private func createApiStub() -> LexinApiStub {
        return LexinApiStub(network: NetworkServiceStub(cache: CacheServiceStub(cache: DataCacheStub(name: "test")), network: NetworkStub()),
                            parserWords: LexinParserWordsStub(),
                            parserSuggestions: LexinParserSuggestionStub())
    }
}
