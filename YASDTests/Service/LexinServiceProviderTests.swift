//
//  LexinServiceProvider.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 22/08/2019.
//  Copyright © 2019 yac. All rights reserved.
//

@testable import YASD

import XCTest
import Cuckoo

class LexinServiceParsersTests: XCTestCase {
    func testDefaultParser() {
        testParser(parser: LexinServiceParserDefault(htmlParser: createMockHtmlParser()))
    }
    
    func testSwedishParser() {
        testParser(parser: LexinServiceParserSwedish(htmlParser: createMockHtmlParser()))
    }
    
    func testFolketsParser() {
        testParser(parser: LexinServiceParserFolkets(htmlParser: createMockHtmlParser()))
    }
    
    private func testParser(parser: LexinServiceParser) {
        // Arrange
        let testData = "test data"
        
        // Act
        let res = try? parser.parseHtml(text: testData)
        
        // Assert
        XCTAssertEqual(res, [LexinServiceResultItem(word: testData), LexinServiceResultItem(word: testData)])
        XCTAssertFalse(parser.getUrl().isEmpty)
        XCTAssert(parser.getRequestParameters(word: testData, parameters: testData).0!.contains(testData))
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
    
    fileprivate func createMockHtmlParser() -> MockHtmlParser {
        let mock = MockHtmlParser()
        stub(mock) { stub in
            when(stub.parse(html: any(), query: any())).then { html, query in
                return [ MockHtmlParserElement1(data: html), MockHtmlParserElement2(data: html)]
            }
        }
        return mock
    }
    
    fileprivate func createMockHtmlParserError(error: Error) -> MockHtmlParser {
        let mock = MockHtmlParser()
        stub (mock) { stub in
            when(stub.parse(html: any(), query: any())).thenThrow(error)
        }
        return mock
    }
}
