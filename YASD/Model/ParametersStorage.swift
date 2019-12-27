//
//  ParametersStorage.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift

class ParametersStorage {
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
    public static let defaultLanguage = ParametersStorage.supportedLanguages[17]
    
    public let language: BehaviorSubject<Language>
    
    private let storage: Storage
    
    init(storage: Storage, language: Language) {
        self.storage = storage
        self.language = BehaviorSubject<Language>(value: language)
        
        load() // FIXME: this is wrong
    }
    
    private func load() {
        setLanguage(storage.get(id: "language", defaultObject: getLanguage()))
    }
    
    func getLanguageString() -> String {
        return "swe" + "_" + getLanguageCode()
    }
    
    func getLanguageCode() -> String {
        return getLanguage().code
    }
    
    func setLanguage(_ language: Language) {
        try? storage.save(id: "language", object: language)
        self.language.onNext(language)
    }
    
    func getLanguage() -> Language {
        return (try? language.value()) ?? ParametersStorage.defaultLanguage
    }
}

struct Language: Codable {
    var name: String
    var code: String
}

extension Language: Equatable {
    static public func == (lhs: Language, rhs: Language) -> Bool {
        return (lhs.name == rhs.name && lhs.code == rhs.code)
    }
}
