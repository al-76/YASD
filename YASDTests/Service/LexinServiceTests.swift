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

    func testSearchWord() {
        testSearch(htmlParser: createMockHtmlParserWord())
    }
    
    func testSearchLemma() {
        testSearch(htmlParser: createMockHtmlParserLemma())
    }
    
    func testSearchNilService() {
        // Arrange
        let testData = "test"
        let scheduler = TestScheduler(initialClock: 0)
        var service : LexinService? = createLexinService(mockNetwork: createMockNetwork(data: testData),
                                         mockHtmlParser: createMockHtmlParserWord())
        
        // Act
        let found = service!.search(word: "test")
        service = nil
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, LexinServiceResult.success([])),
            .completed(200)
            ])
    }

    func testSearchError() {
        // Arrange
        let testError = TestError.someError
        let scheduler = TestScheduler(initialClock: 0)
        let service = createLexinService(mockNetwork: createMockNetwork(data: "test"),
                                         mockHtmlParser: createMockHtmlParserError(error: testError))
        
        // Act
        let found = service.search(word: "test")
        let res = scheduler.start { found }
        
        XCTAssertEqual(res.events, [
            .next(200, LexinServiceResult.failure(testError)),
            .completed(200)
            ])

    }
    
    fileprivate func testSearch(htmlParser: MockHtmlParser) {
        // Arrange
        let testData = "test"
        let scheduler = TestScheduler(initialClock: 0)
        let service = createLexinService(mockNetwork: createMockNetwork(data: testData),
                                         mockHtmlParser: htmlParser)
        
        // Act
        let found = service.search(word: "test")
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, LexinServiceResult.success([LexinServiceResultItem(word: testData), LexinServiceResultItem(word: testData)])),
            .completed(200)
            ])
    }

    fileprivate func createLexinService(mockNetwork: MockNetwork, mockHtmlParser: MockHtmlParser) -> LexinService {
        return LexinService(network: mockNetwork,
                            htmlParser: mockHtmlParser,
                            parameters: LexinServiceParameters(language: MockLexinServiceParameters.Language(name: "test", code: "test")),
                            formatter: MockLexinServiceFormatter(markdown: MockMarkdown()))
    }
    
    fileprivate func createMockNetwork(data: String) -> MockNetwork {
        let mock = MockNetwork()
        stub(mock) { mock in
            when(mock.postRequest(url: anyString(), parameters: any())).then { url, parameters in
                return Observable<String>.just(data)
            }
        }
        return mock
    }
    
    class MockHtmlParserElement1 : HtmlParserElement {
        let data: String
        
        init(data: String) {
            self.data = data
        }
        
        func attribute(_ id: String) throws -> String {
            return data
        }
        
        func text() throws -> String {
            return data
        }
        
        func selectText(_ query: String) throws -> String {
            return "Text: " + query
        }
        
        func selectTexts(_ query: String) throws -> [String] {
            return [ "Texts: " + query ]
        }
        
        func selectElements(_ query: String) throws -> [HtmlParserElement] {
            return [ MockHtmlParserElement1(data: query) ]
        }
    }
    
    class MockHtmlParserElement2 : MockHtmlParserElement1 {
        override func selectElements(_ query: String) throws -> [HtmlParserElement] {
            return []
        }
    }
    
    fileprivate func createMockHtmlParserWord() -> MockHtmlParser {
        return createMockHtmlParser(parserQuery: "Word")
    }
    
    fileprivate func createMockHtmlParserLemma() -> MockHtmlParser {
        return createMockHtmlParser(parserQuery: "Lemma")
    }
    
    fileprivate func createMockHtmlParser(parserQuery: String) -> MockHtmlParser {
        let mock = MockHtmlParser()
        stub(mock) { mock in
            when(mock.parse(html: any(), query: any())).then { html, query in
                return (parserQuery == query) ? [ MockHtmlParserElement1(data: html), MockHtmlParserElement2(data: html) ] : []
            }
        }
        return mock
    }
    
    fileprivate func createMockHtmlParserError(error: Error) -> MockHtmlParser {
        let mock = MockHtmlParser()
        stub (mock) { mock in
            when(mock.parse(html: any(), query: any())).thenThrow(error)
        }
        return mock
    }
}
