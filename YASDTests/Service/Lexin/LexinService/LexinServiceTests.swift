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
    func testSearch() {
        // Arrange
        let testData = LexinWordResult.success([LexinWord(word: "test")])
        let scheduler = TestScheduler(initialClock: 0)
        let lexin = createLexinRepository(createMockApiSearch(testData))
        
        // Act
        let found = lexin.search("test")
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, LexinWordResult.success([LexinWord(word: "test")])),
            .completed(200)
       ])
    }
    
    func testSuggestion() {
        // Arrange
        let testData = SuggestionResult.success(["Test"])
        let scheduler = TestScheduler(initialClock: 0)
        let lexin = createLexinRepository(createMockApiSuggestion(testData))
        
        // Act
        let found = lexin.suggestion("test")
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, testData),
            .completed(200)
           ])
    }

    private func createLexinRepository(_ lexinApi: LexinApi) -> LexinRepository {
        return LexinRepositoryImpl(parameters: ParametersStorage(storage: createMockStorage(),
                                                          language: Language(name: "test", code: "test")),
                            provider: createMockLexinApiProvider(lexinApi))
    }
    
    private func createMockApiSuggestion(_ suggestionData: SuggestionResult) -> LexinApi {
        let mock = MockLexinApi(network: createMockNetwork(),
                                parserWords: MockLexinParserWords(),
                                parserSuggestions: MockLexinParserSuggestion())
        let suggestionResult = Observable.just(suggestionData)
        stub(mock) { stub in
            when(stub.suggestion(any(), with: any())).thenReturn(suggestionResult)
        }
        return mock
    }
    
    private func createMockApiSearch(_ searchData: LexinWordResult) -> LexinApi {
        let mock = MockLexinApi(network: createMockNetwork(),
                                parserWords: MockLexinParserWords(),
                                parserSuggestions: MockLexinParserSuggestion())
        let searchResult = Observable.just(searchData)
        stub(mock) { stub in
            when(stub.search(any(), with: any())).thenReturn(searchResult)
        }
        return mock
    }
    
    private func createMockLexinApiProvider(_ api: LexinApi) -> LexinApiProvider {
        let mock = MockLexinApiProvider(defaultApi: api, folketsApi: api, swedishApi: api)
        stub(mock) { stub in
            when(stub.getApi(by: any())).thenReturn(api)
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
            when(stub.get(id: anyString(), defaultObject: any(Language.self)))
                .then { id, defaultObject -> Language in return defaultObject }
            when(stub.save(id: anyString(), object: any(Language.self))).thenDoNothing()
        }
        return mock
    }
}
