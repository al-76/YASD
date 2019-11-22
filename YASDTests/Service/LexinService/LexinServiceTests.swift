//
//  LexinServiceTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 28/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//
@testable import YASD

import XCTest
import RxSwift
import RxTest
import Cuckoo

class LexinServiceTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    func testSearch() {
        // Arrange
        let testData = LexinParserWordsResult.success([ LexinParserWordsResultItem(word: "test") ])
        let scheduler = TestScheduler(initialClock: 0)
        let service = createLexinService(createMockApiSearch(testData))
        
        // Act
        let found = service.search(word: "test")
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, testData),
            .completed(200)
            ])
    }
    
    func testSuggestion() {
        // Arrange
        let testData = LexinParserSuggestionResult.success([ "Test" ])
        let scheduler = TestScheduler(initialClock: 0)
        let service = createLexinService(createMockApiSuggestion(testData))
        
        // Act
        let found = service.suggestion(word: "test")
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, testData),
            .completed(200)
            ])
    }


    private func createLexinService(_ lexinApi: LexinApi) -> LexinService {
        return LexinService(parameters: LexinServiceParameters(storage: createMockStorage(),
                                                               language: MockLexinServiceParameters.Language(name: "test", code: "test")),
                            provider: createMockLexinApiProvider(lexinApi))
    }
    
    private func createMockApiSuggestion(_ suggestionData: LexinParserSuggestionResult) -> LexinApi {
        let mock = MockLexinApi(network: createMockNetwork(),
                                   parserWords: MockLexinParserWords(),
                                   parserSuggestions: MockLexinParserSuggestion())
        let suggestionResult = Observable.just(suggestionData)
        stub(mock) { stub in
            when(stub.suggestion(word: any(), language: any())).thenReturn(suggestionResult)
        }
        return mock
    }
    
    private func createMockApiSearch(_ searchData: LexinParserWordsResult) -> LexinApi {
        let mock = MockLexinApi(network: createMockNetwork(),
                                   parserWords: MockLexinParserWords(),
                                   parserSuggestions: MockLexinParserSuggestion())
        let searchResult = Observable.just(searchData)
        stub(mock) { stub in
            when(stub.search(word: any(), language: any())).thenReturn(searchResult)
        }
        return mock
    }
    
    private func createMockLexinApiProvider(_ api: LexinApi) -> LexinApiProvider {
        let mock = MockLexinApiProvider(defaultApi: api, folketsApi: api, swedishApi: api)
        stub(mock) { stub in
            when(stub.getApi(language: any())).thenReturn(api)
        }
        return mock
    }
    
    private func createMockNetwork() -> MockNetworkService {
        let mockCache = MockCacheService(cache: MockDataCache(name: "Test"))
        return MockNetworkService(cache: mockCache, network: MockNetwork())
    }

    private func createMockStorage() -> MockStorage {
        let mock = MockStorage()
        stub(mock) { stub in
            when(stub.get(id: anyString(), defaultObject: any(LexinServiceParameters.Language.self)))
                .then { id, defaultObject -> LexinServiceParameters.Language in return defaultObject }
            when(stub.save(id: anyString(), object: any(LexinServiceParameters.Language.self))).thenDoNothing()
        }
        return mock
    }
}
