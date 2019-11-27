//
//  LexinApiTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 21/11/2019.
//  Copyright © 2019 yac. All rights reserved.
//

@testable import YASD

import XCTest
import RxSwift
import RxTest
import Cuckoo

class LexinApiTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    override func setUp() {
        DefaultValueRegistry.register(value: Observable.just("test"), forType: Observable<String>.self)
    }
    
    func testSearch() {
        // Arrange
        let testData = [ LexinWord(word: "test_result") ]
        let api = LexinApi(network: createNetworkStub(),
                           parserWords: createMockLexinParserWords(testData),
                           parserSuggestions: LexinParserSuggestionStub())
        let scheduler = TestScheduler(initialClock: 0)
        
        // Act
        let found = api.search(word: "test", language: "test_lang")
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, LexinWordResult.success(testData)),
            .completed(200)
        ])
    }
    
    func testSearchError() {
        // Arrange
        let api = LexinApi(network: createNetworkStub(),
                           parserWords: createMockLexinParserWordsError(),
                           parserSuggestions: LexinParserSuggestionStub())
        let scheduler = TestScheduler(initialClock: 0)
        
        // Act
        let found = api.search(word: "test", language: "test_lang")
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, LexinWordResult.failure(TestError.someError)),
            .completed(200)
        ])
    }
    
    func testSearchEmpty() {
        // Arrange
        let api = LexinApi(network: createNetworkStub(),
                           parserWords: LexinParserWordsStub(),
                           parserSuggestions: LexinParserSuggestionStub())
        let scheduler = TestScheduler(initialClock: 0)
        
        // Act
        let found = api.search(word: "", language: "test_lang")
        let res = scheduler.start { found }

        // Assert
        XCTAssertEqual(res.events, [
            .next(200, LexinWordResult.success([])),
            .completed(200)
        ])
    }
    
    func testSuggestion() {
        // Arrange
        let testData = [ "test_suggestion" ]
        let api = LexinApi(network: createNetworkStub(),
                           parserWords: LexinParserWordsStub(),
                           parserSuggestions: createMockLexinParserSuggestion(testData))
        let scheduler = TestScheduler(initialClock: 0)

        // Act
        let found = api.suggestion(word: "test", language: "test_lang")
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, SuggestionResult.success(testData)),
            .completed(200)
        ])

    }
    
    func testSuggestionError() {
        // Arrange
        let api = LexinApi(network: createNetworkStub(),
                           parserWords: LexinParserWordsStub(),
                           parserSuggestions: createMockLexinParserSuggestionError())
        let scheduler = TestScheduler(initialClock: 0)

        // Act
        let found = api.suggestion(word: "test", language: "test_lang")
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, SuggestionResult.failure(TestError.someError)),
            .completed(200)
        ])

    }
    
    func testSuggestionEmpty() {
        // Arrange
        let api = LexinApi(network: createNetworkStub(),
                           parserWords: LexinParserWordsStub(),
                           parserSuggestions: LexinParserSuggestionStub())
        let scheduler = TestScheduler(initialClock: 0)

        // Act
        let found = api.suggestion(word: "", language: "test_lang")
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, SuggestionResult.success([])),
            .completed(200)
        ])
    }
    
    private func createNetworkStub() -> NetworkServiceStub {
        let cache = CacheServiceStub(cache: DataCacheStub(name: "Test"))
        return NetworkServiceStub(cache: cache, network: NetworkStub())
    }
    
    private func createMockLexinParserWords(_ value: [ LexinWord ]) -> MockLexinParserWords {
        let mock = MockLexinParserWords()
        stub(mock) { stub in
            when(stub.getRequestParameters(word: any(), language: any())).thenReturn(Network.PostParameters(url: "test", headers: nil))
            when(stub.parse(text: any())).thenReturn(value)
        }
        return mock
    }
    
    private func createMockLexinParserWordsError() -> MockLexinParserWords {
        let mock = MockLexinParserWords()
        stub(mock) { stub in
            when(stub.getRequestParameters(word: any(), language: any())).thenReturn(Network.PostParameters(url: "test", headers: nil))
            when(stub.parse(text: any())).thenThrow(TestError.someError)
        }
        return mock
    }
    
    private func createMockLexinParserSuggestion(_ value: [ String ]) -> MockLexinParserSuggestion {
        let mock = MockLexinParserSuggestion()
        stub(mock) { stub in
            when(stub.getRequestParameters(word: any(), language: any())).thenReturn(Network.PostParameters(url: "test", headers: nil))
            when(stub.parse(text: any())).thenReturn(value)
        }
        return mock
    }
    
    private func createMockLexinParserSuggestionError() -> MockLexinParserSuggestion {
        let mock = MockLexinParserSuggestion()
        stub(mock) { stub in
            when(stub.getRequestParameters(word: any(), language: any())).thenReturn(Network.PostParameters(url: "test", headers: nil))
            when(stub.parse(text: any())).thenThrow(TestError.someError)
        }
        return mock
    }
}
