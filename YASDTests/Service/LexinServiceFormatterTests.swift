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
        let testLang = LexinServiceResultItem.Lang(meaning: "meaning",
                                                   phonetic: nil,
                                                   inflection: [ "1", "2" ],
                                                   grammar: nil,
                                                   example: [ LexinServiceResultItem.Item(id: "1", value: "example") ],
                                                   idiom: nil,
                                                   compound: nil,
                                                   translation: nil,
                                                   reference: "reference",
                                                   synonym: "synonym")
        let formatter = LexinServiceFormatter(markdown: createMockMarkdown())
        let result = LexinServiceResult.success([
            LexinServiceResultItem(word: "word"),
            LexinServiceResultItem(word: "word", type: nil),
            LexinServiceResultItem(word: "word", type: "type",
                                   baseLang: testLang,
                                   targetLang: testLang,
                                   lexemes: nil),
            LexinServiceResultItem(word: "word", type: "type",
                                   baseLang: testLang,
                                   targetLang: nil,
                                   lexemes: nil),
            LexinServiceResultItem(word: "word", type: "type",
                                   baseLang: nil,
                                   targetLang: nil,
                                   lexemes: [testLang, testLang]),
            LexinServiceResultItem(word: "word", type: "type",
                                   baseLang: testLang,
                                   targetLang: nil,
                                   lexemes: [testLang, testLang]),
            LexinServiceResultItem(word: "word", type: "type",
                                   baseLang: nil,
                                   targetLang: nil,
                                   lexemes: nil)
            ])
        
        // Act
        let strings = formatter.format(result: result)
        
        // Assert
        XCTAssertEqual(strings, LexinServiceResultFormatted.success([
            NSAttributedString(string: "# word [] (test)\n### (word)\n"),
            NSAttributedString(string: "# word [] \n### (word)\n"),
            NSAttributedString(string: "# word [] (type reference)\n### (word, 1, 2)\n (synonym)\n*meaning*\n\n## Exempel:\n* example - example\n"),
            NSAttributedString(string: "# word [] (type reference)\n### (word, 1, 2)\n*meaning*\n\n## Exempel:\n* example\n"),
            NSAttributedString(string: "# word [] (type reference)\n### (word, 1, 2)\n*meaning*\n\n## Exempel:\n* example\n\n*meaning*\n\n## Exempel:\n* example\n"),
            NSAttributedString(string: "# word [] (type reference)\n### (word, 1, 2)\n*meaning*\n\n## Exempel:\n* example\n"),
            NSAttributedString(string: "# word [] (type)\n### (word)\n")
            ]))
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
                print("line")
                print(data)
                return NSAttributedString(string: data)
            }
        }
        return mock
    }
}
