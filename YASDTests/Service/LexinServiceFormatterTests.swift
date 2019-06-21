//
//  LexinServiceFormatterTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 21/06/2019.
//  Copyright © 2019 yac. All rights reserved.
//
@testable import YASD

import XCTest
import RxSwift
import RxTest
import Cuckoo

class LexinServiceFormatterTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    func testFormat() {
        // Arrange
        let testId = "test"
        let testLang = LexinServiceResultItem.Lang(meaning: "meaning",
                                                   phonetic: nil,
                                                   inflection: [ "1", "2" ],
                                                   grammar: nil,
                                                   example: [ LexinServiceResultItem.Item(id: "1", value: "example") ],
                                                   idiom: nil,
                                                   compound: nil,
                                                   translation: nil)
        let formatter = LexinServiceFormatter(markdown: createMockMarkdown(id: testId))
        let result = LexinServiceResult.success([
            LexinServiceResultItem(word: "word"),
            LexinServiceResultItem(word: "word", type: nil),
            LexinServiceResultItem(word: "word", type: "type",
                                   baseLang: testLang,
                                   targetLang: testLang),
            LexinServiceResultItem(word: "word", type: "type",
                                   baseLang: testLang,
                                   targetLang: nil)
            ])
        
        // Act
        let strings = formatter.format(result: result)
        
        // Assert
        XCTAssertEqual(strings, LexinServiceResultFormatted.success([
            NSAttributedString(string: testId),
            NSAttributedString(string: testId),
            NSAttributedString(string: testId),
            NSAttributedString(string: testId) ]))
    }
    
    func testFormatError() {
        // Arrange
        let testId = "test"
        let formatter = LexinServiceFormatter(markdown: createMockMarkdown(id: testId))
        let error = LexinServiceResult.failure(TestError.someError)
        
        // Act
        let strings = formatter.format(result: error)
        
        // Assert
        XCTAssertEqual(strings, LexinServiceResultFormatted.failure(TestError.someError))
    }
    
    func createMockMarkdown(id: String) -> MockMarkdown {
        let mock = MockMarkdown()
        stub (mock) { mock in
            when(mock.parse(data: any())).then { data in
                return NSAttributedString(string: id)
            }
        }
        return mock
    }
}
