//
//  LexinServiceResultItem+Extensions.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 21/06/2019.
//  Copyright © 2019 yac. All rights reserved.
//

@testable import YASD

extension LexinServiceResultItem {
    public init(word: String) {
        self.init(word: word, type: "test", baseLang: Lang(), targetLang: Lang())
    }
    
    public init(word: String, type: String?) {
        self.init(word: word, type: type, baseLang: Lang(), targetLang: Lang())
    }
}

extension LexinServiceResultItem: Equatable {
    static public func == (lhs: LexinServiceResultItem, rhs: LexinServiceResultItem) -> Bool {
        return lhs.word == rhs.word
    }
}
