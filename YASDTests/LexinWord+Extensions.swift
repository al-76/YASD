//
//  LexinWord+Extensions.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 21/06/2019.
//  Copyright © 2019 yac. All rights reserved.
//

@testable import YASD

extension LexinWord {
    init(word: String) {
        self.init(word: word, type: "test", baseLang: Lang(), targetLang: Lang(), lexemes: nil)
    }

    init(word: String, type: String?) {
        self.init(word: word, type: type, baseLang: Lang(), targetLang: Lang(), lexemes: nil)
    }
}

extension LexinWord: Equatable {
    public static func == (lhs: LexinWord, rhs: LexinWord) -> Bool {
        return lhs.word == rhs.word
    }
}
