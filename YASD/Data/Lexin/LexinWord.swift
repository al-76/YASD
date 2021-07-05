//
//  LexinWord.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation

typealias LexinWordResult = Result<[LexinWord]>

struct LexinWord {
    struct Item {
        var id: String
        var value: String
    }

    struct Lang {
        var meaning: String?
        var phonetic: String?
        var inflection: [String?]?
        var grammar: String?
        var example: [Item]?
        var idiom: [Item]?
        var compound: [Item]?
        var translation: String?
        var reference: String?
        var synonym: [String?]?
        var soundUrl: String?
    }

    var word: String
    var type: String?
    var baseLang: Lang?
    var targetLang: Lang?
    var lexemes: [Lang]?
}
