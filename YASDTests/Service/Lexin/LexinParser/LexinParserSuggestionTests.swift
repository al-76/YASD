////
////  LexinParserSuggestionTests.swift
////  YASDTests
////
////  Created by Vyacheslav Konopkin on 22.11.2019.
////  Copyright © 2019 yac. All rights reserved.
////
//
//@testable import YASD
//
//import XCTest
//import Cuckoo
//
//class LexinParserSuggestionTests: XCTestCase {
//    func testDefaultParser() {
//        testParser(parser: LexinParserSuggestionDefault())
//    }
//    
//    func testFolketsParser() {
//        testParser(parser: LexinParserSuggestionFolkets())
//    }
//    
//    private func testParser(parser: LexinParserSuggestion) {
//        // Arrange
//        let testData = "test data"
//        
//        // Act
//        let res = try? parser.parse(text: testData + "0" + "," + testData + "1")
//        
//        // Assert
//        XCTAssertEqual(res, [testData + "0", testData + "1"])
//        XCTAssertFalse(parser.getRequestParameters(testData, with: testData).url.isEmpty)
//        XCTAssert(parser.getRequestParameters(testData, with: testData).parameters!.0!.contains(testData))
//    }
//
//}
