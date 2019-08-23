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
    
    func testSearchError() {
        // Arrange
        let testError = TestError.someError
        let scheduler = TestScheduler(initialClock: 0)
        let service = createLexinService(parser: MockLexinServiceParserError(error: testError))

        // Act
        let found = service.search(word: "test")
        let res = scheduler.start { found }

        // Assert
        XCTAssertEqual(res.events, [
            .next(200, LexinServiceResult.failure(testError)),
            .completed(200)
            ])

    }
    
    func testSearch() {
        // Arrange
        let testData = "test"
        let scheduler = TestScheduler(initialClock: 0)
        let service = createLexinService(parser: MockLexinServiceParser(data: testData))
        
        // Act
        let found = service.search(word: "test")
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, LexinServiceResult.success([LexinServiceResultItem(word: testData)])),
            .completed(200)
            ])
    }

    fileprivate func createLexinService(parser: LexinServiceParser) -> LexinService {
        return LexinService(network: createMockNetwork(),
                            parameters: LexinServiceParameters(language: MockLexinServiceParameters.Language(name: "test", code: "test")),
                            formatter: MockLexinServiceFormatter(markdown: MockMarkdown()),
                            provider: createMockLexinServiceProvider(parser: parser))
    }
    
    
    fileprivate func createLexinServiceParameters() -> LexinServiceParameters {
        let mock = MockLexinServiceParameters(language: MockLexinServiceParameters.Language(name: "test", code: "test"))
        stub(mock) { stub in
            when(stub.get()).thenReturn("test")
        }
        return mock
    }
    
    fileprivate func createMockLexinServiceProvider(parser: LexinServiceParser) -> LexinServiceProvider {
        let mock = MockLexinServiceProvider(defaultParser: parser, folketsParser: parser, swedishParser: parser)
        stub(mock) { stub in
            when(stub.getParser(language: any())).thenReturn(parser)
        }
        return mock
    }
    
    class MockLexinServiceParser : LexinServiceParser {
        let data: String
        
        init(data: String) {
            self.data = data
        }
        
        func getUrl() -> String {
            return "test"
        }
        
        func getRequestParameters(word: String, parameters: String) -> (String?, [String : String]?) {
            return ("test", ["test": "test"])
        }
        
        func parseHtml(text: String) throws -> [LexinServiceResultItem] {
            return [ LexinServiceResultItem(word: data) ]
        }
    }
    
    class MockLexinServiceParserError : LexinServiceParser {
        let error: Error
        
        init(error: Error) {
            self.error = error
        }
        
        func getUrl() -> String {
            return "test"
        }
        
        func getRequestParameters(word: String, parameters: String) -> (String?, [String : String]?) {
            return ("test", ["test": "test"])
        }
        
        func parseHtml(text: String) throws -> [LexinServiceResultItem] {
            throw(error)
        }
    }

    fileprivate func createMockNetwork() -> MockNetwork {
        let mock = MockNetwork()
        stub(mock) { stub in
            when(stub.postRequest(url: anyString(), parameters: any())).then { url, parameters in
                return Observable<String>.just("")
            }
        }
        return mock
    }
}
