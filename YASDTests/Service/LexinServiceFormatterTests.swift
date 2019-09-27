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
    
    var testLang: LexinServiceResultItem.Lang!
    
    override func setUp() {
        testLang = LexinServiceResultItem.Lang(meaning: "meaning",
                                               phonetic: nil,
                                               inflection: [ "1", "2" ],
                                               grammar: nil,
                                               example: [ LexinServiceResultItem.Item(id: "1", value: "example") ],
                                               idiom: nil,
                                               compound: nil,
                                               translation: nil,
                                               reference: "reference",
                                               synonym: ["synonym"],
                                               soundUrl: nil)
    }
    
    func testFormat1() {
        let result = LexinServiceResult.success([ LexinServiceResultItem(word: "word") ])
        let formattedResult = LexinServiceResultFormatted.success([ LexinServiceResultFormattedItem(formatted: NSAttributedString(string: "# word (test)\n"), soundUrl: nil) ])
        testFormat(result: result, formattedResult: formattedResult)
    }
    
    func testFormat2() {
        let result = LexinServiceResult.success([ LexinServiceResultItem(word: "word", type: nil) ])
        let formattedResult = LexinServiceResultFormatted.success([ LexinServiceResultFormattedItem(formatted: NSAttributedString(string: "# word \n"), soundUrl: nil) ])
        testFormat(result: result, formattedResult: formattedResult)
    }
    
    func testFormat3() {
        let result = LexinServiceResult.success([ LexinServiceResultItem(word: "word", type: "type",
                                                                         baseLang: testLang,
                                                                         targetLang: testLang,
                                                                         lexemes: nil) ])
        let formattedResult = LexinServiceResultFormatted.success([ LexinServiceResultFormattedItem(formatted: NSAttributedString(string: "# word (type reference)\n### (word, 1, 2)\n (synonym)\n*meaning*\n\n## Exempel:\n* example - example\n"), soundUrl: nil) ])
        testFormat(result: result, formattedResult: formattedResult)
    }
    
    func testFormat4() {
        let result = LexinServiceResult.success([ LexinServiceResultItem(word: "word", type: "type",
                                                                         baseLang: testLang,
                                                                         targetLang: nil,
                                                                         lexemes: nil) ])
        let formattedResult = LexinServiceResultFormatted.success([ LexinServiceResultFormattedItem(formatted: NSAttributedString(string: "# word (type reference)\n### (word, 1, 2)\n (synonym)\n*meaning*\n\n## Exempel:\n* example\n"), soundUrl: nil) ])
        testFormat(result: result, formattedResult: formattedResult)
    }
    
    func testFormat5() {
        let result = LexinServiceResult.success([ LexinServiceResultItem(word: "word", type: "type",
                                                                         baseLang: nil,
                                                                         targetLang: nil,
                                                                         lexemes: [testLang, testLang]) ])
        let formattedResult = LexinServiceResultFormatted.success([ LexinServiceResultFormattedItem(formatted: NSAttributedString(string: "# word (type reference)\n### (word, 1, 2)\n (synonym)\n*meaning*\n\n## Exempel:\n* example\n\n*meaning*\n\n## Exempel:\n* example\n"), soundUrl: nil) ])
        testFormat(result: result, formattedResult: formattedResult)
    }
    
    func testFormat6() {
        let result = LexinServiceResult.success([ LexinServiceResultItem(word: "word", type: "type",
                                                                         baseLang: testLang,
                                                                         targetLang: nil,
                                                                         lexemes: [testLang, testLang]) ])
        let formattedResult = LexinServiceResultFormatted.success([ LexinServiceResultFormattedItem(formatted: NSAttributedString(string: "# word (type reference)\n### (word, 1, 2)\n (synonym)\n*meaning*\n\n## Exempel:\n* example\n"), soundUrl: nil) ])
        testFormat(result: result, formattedResult: formattedResult)
    }
    
    func testFormat7() {
        let result = LexinServiceResult.success([ LexinServiceResultItem(word: "word", type: "type",
                                                                         baseLang: nil,
                                                                         targetLang: nil,
                                                                         lexemes: nil) ])
        let formattedResult = LexinServiceResultFormatted.success([ LexinServiceResultFormattedItem(formatted: NSAttributedString(string: "# word (type)\n"), soundUrl: nil) ])
        testFormat(result: result, formattedResult: formattedResult)
    }
    
    func testFormat8() {
        testLang?.phonetic = "phonetic"
        let result = LexinServiceResult.success([ LexinServiceResultItem(word: "word", type: "type",
                                                                         baseLang: testLang,
                                                                         targetLang: nil,
                                                                         lexemes: nil) ])
        let formattedResult = LexinServiceResultFormatted.success([ LexinServiceResultFormattedItem(formatted: NSAttributedString(string: "# word [phonetic] (type reference)\n### (word, 1, 2)\n (synonym)\n*meaning*\n\n## Exempel:\n* example\n"), soundUrl: nil) ])
        testFormat(result: result, formattedResult: formattedResult)
    }
    
    private func testFormat(result: LexinServiceResult, formattedResult: LexinServiceResultFormatted) {
        // Arrange
        let formatter = LexinServiceFormatter(markdown: createMockMarkdown())
        
        // Act
        let strings = formatter.format(result: result)
        
        // Assert
        XCTAssertEqual(strings, formattedResult)
    }
    
    func testFormatError() {
        // Arrange
        let formatter = LexinServiceFormatter(markdown: createMockMarkdown())
        let error = LexinServiceResult.failure(TestError.someError)
        
        // Act
        let strings = formatter.format(result: error)
        
        // Assert
        XCTAssertEqual(strings, LexinServiceResultFormatted.failure(TestError.someError))
    }
    
    func createMockMarkdown() -> MockMarkdown {
        let mock = MockMarkdown()
        stub (mock) { mock in
            when(mock.parse(data: any())).then { data in
                return NSAttributedString(string: data)
            }
        }
        return mock
    }
}
