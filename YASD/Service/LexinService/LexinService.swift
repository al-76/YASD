//
//  LexinService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import Foundation

class LexinServiceParameters {
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
    public static let defaultLanguage = LexinServiceParameters.supportedLanguages[17]
    
    struct Language: Codable {
        var name: String
        var code: String
    }
    
    public let language: BehaviorSubject<Language>
    
    private let storage: Storage
    
    init(storage: Storage, language: Language) {
        self.storage = storage
        self.language = BehaviorSubject<Language>(value: language)
        
        load()
    }
    
    private func load() {
        setLanguage(language: storage.get(id: "language", defaultObject: getLanguage()))
    }
    
    func getLanguageString() -> String {
        return "swe" + "_" + getLanguageCode()
    }
    
    func getLanguageCode() -> String {
        return getLanguage().code
    }
    
    func setLanguage(language: Language) {
        try? storage.save(id: "language", object: language)
        self.language.onNext(language)
    }
    
    func getLanguage() -> Language {
        return (try? language.value()) ?? LexinServiceParameters.defaultLanguage
    }
}

extension LexinServiceParameters.Language: Equatable {
    static public func == (lhs: LexinServiceParameters.Language, rhs: LexinServiceParameters.Language) -> Bool {
        return (lhs.name == rhs.name && lhs.code == rhs.code)
    }
}

class LexinService {
    private let parameters: LexinServiceParameters
    private let provider: LexinApiProvider

    init(parameters: LexinServiceParameters, provider: LexinApiProvider) {
        self.parameters = parameters
        self.provider = provider
    }

    func search(word: String) -> Observable<LexinParserWordsResult> {
        return provider.getApi(language: parameters.getLanguage())
            .search(word: word, language: parameters.getLanguageString())
    }
    
    func suggest(word: String) -> Observable<LexinParserSuggestionResult> {
        return provider.getApi(language: parameters.getLanguage())
            .suggestion(word: word, language: parameters.getLanguageString())
    }
    
    func language() -> BehaviorSubject<LexinServiceParameters.Language> {
        return parameters.language
    }
}
