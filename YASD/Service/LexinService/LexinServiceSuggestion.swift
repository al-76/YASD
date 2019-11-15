//
//  LexinServiceSuggestion.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 09/10/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift

typealias LexinServiceSuggestionResultItem = String?
typealias LexinServiceSuggestionResult = Result<[LexinServiceSuggestionResultItem]>

class LexinServiceSuggestion {
    private let network: NetworkService
    private let parameters: LexinServiceParameters
    private let provider: LexinServiceProviderSuggestion
    
    init(network: NetworkService, parameters: LexinServiceParameters, provider: LexinServiceProviderSuggestion) {
        self.network = network
        self.parameters = parameters
        self.provider = provider
    }
    
    func suggest(word: String) -> Observable<LexinServiceSuggestionResult> {
        if word.isEmpty {
            return Observable.just(.success([nil]))
        }
        let parser = provider.getParser(language: parameters.getLanguage())
        return network.postRequest(with: parser.getRequestParameters(word: word, language: parameters.getLanguageString()))
            .map { do {
                    return try .success(parser.parse(text: $0))
                } catch let error {
                    return .failure(error)
                }
            }
    }
}

//class LexinServiceAbstract<TypeProvider, TypeParser> {
//    let parameters: LexinServiceParameters
//
//    private let network: NetworkService
//    private let provider: LexinServiceProvider<TypeProvider>
//
//    init(network: NetworkService, parameters: LexinServiceParameters, provider: LexinServiceProvider<TypeProvider>) {
//        self.network = network
//        self.parameters = parameters
//        self.provider = provider
//    }
//
//    func search(word: String) -> Observable<LexinServiceResult> {
//        if word.isEmpty {
//            return Observable.just(.success([nil]))
//        }
//        let parser = provider.getParser(language: parameters.getLanguage())
//        return network.postRequest(url: parser.getUrl(),
//                                   parameters: parser.getRequestParameters(word: word, parameters: parameters.get()))
//            .map { do {
//                    let text = String(data: $0, encoding: .utf8) ?? ""
//                    return try .success(parser.parse(text: text))
//                } catch let error {
//                    return .failure(error)
//                }
//            }
//    }
//}
