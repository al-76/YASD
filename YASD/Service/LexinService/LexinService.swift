//
//  LexinService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift

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
    }
    
    func load() {
        setLanguage(language: storage.get(id: "language", defaultObject: getLanguage()))
    }
    
    func get() -> String {
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

typealias LexinServiceResult = Result<[LexinServiceResultItem]>

struct LexinServiceResultItem {
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

class LexinService {
    public let parameters: LexinServiceParameters
    
    private let network: NetworkService
    private let provider: LexinServiceProvider
    
    init(network: NetworkService, parameters: LexinServiceParameters, provider: LexinServiceProvider) {
        self.network = network
        self.parameters = parameters
        self.provider = provider
    }
    
    func search(word: String) -> Observable<LexinServiceResult> {
        if word.isEmpty {
            return Observable<LexinServiceResult>.just(.success([]))
        }
        let parser = provider.getParser(language: parameters.getLanguage())
        return network.postRequest(url: parser.getUrl(),
                                   parameters: parser.getRequestParameters(word: word, parameters: parameters.get()))
            .map { do {
                    let text = String(data: $0, encoding: .utf8) ?? ""
                    return try .success(parser.parseHtml(text: text))
                } catch let error {
                    return .failure(error)
                }
            }
    }
}
