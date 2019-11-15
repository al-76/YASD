//
//  SearchService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 18.10.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift

//protocol SearchServiceParameters {
//    func get() -> String
//}
//
//class SearchService<P: SearchServiceParameters> {
//    let parameters: P
//
//    private let network: NetworkService
//
//    init(network: NetworkService, parameters: P) {
//        self.network = network
//        self.parameters = parameters
//    }
//
//    func search<T: ProtocolLexinServiceParser>(word: String, parser: T) -> Observable<Result<[T.ResultType]>> {
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
