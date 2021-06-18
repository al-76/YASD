//
//  Language.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 20.02.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation

struct Language: Codable {
    var name: String
    var code: String
}

extension Language: Equatable {
    static public func == (lhs: Language, rhs: Language) -> Bool {
        return (lhs.name == rhs.name && lhs.code == rhs.code)
    }
}

extension Language {
    func getString() -> String {
        return "swe_" + code
    }
}

extension Language {
    public static let defaultLanguage = Language.supportedLanguages[17]
    
    public static let supportedLanguages = [
        Language(name: "albanska", code: "alb"),
        Language(name: "amhariska", code: "amh"),
        Language(name: "arabiska", code: "ara"),
        Language(name: "azerbajdzjanska", code: "azj"),
        Language(name: "bosniska", code: "bos"),
        Language(name: "engelska", code: "eng"),
        Language(name: "finska", code: "fin"),
        Language(name: "grekiska", code: "gre"),
        Language(name: "kroatiska", code: "hrv"),
        Language(name: "nordkurdiska", code: "kmr"),
        Language(name: "pashto", code: "pus"),
        Language(name: "persiska", code: "per"),
        Language(name: "ryska", code: "rus"),
        Language(name: "serbiska (latinskt)", code: "srp"),
        Language(name: "serbiska (kyrilliskt)", code: "srp_cyrillic"),
        Language(name: "somaliska", code: "som"),
        Language(name: "spanska", code: "spa"),
        Language(name: "svenska", code: "swe"),
        Language(name: "sydkurdiska", code: "sdh"),
        Language(name: "tigrisnka", code: "tir"),
        Language(name: "turkiska", code: "tur")
    ]
}
