//
//  FoundWord+Extensions.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 26.12.2019.
//  Copyright © 2019 yac. All rights reserved.
//

@testable import YASD

import Foundation

extension FoundWord {
    public init(_ word: String) {
        let word = FormattedWord(header: word,
                                 formatted: NSAttributedString(string: word),
                                 soundUrl: nil,
                                 definition: "")
        self.init(word: word, bookmarked: true)
    }
}

extension FoundWord: Equatable {
    static public func == (lhs: FoundWord, rhs: FoundWord) -> Bool {
        return lhs.word == rhs.word && lhs.bookmarked == rhs.bookmarked
    }
}
