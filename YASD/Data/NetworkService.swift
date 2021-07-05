//
//  NetworkService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 03/10/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import RxSwift

typealias NetworkServiceResult = Result<String>

class NetworkService {
    private let cache: CacheService
    private let network: Network

    init(cache: CacheService, network: Network) {
        self.cache = cache
        self.network = network
    }

    func getRequest(with url: String) -> Observable<NetworkServiceResult> {
        return cache.run({ [weak self] in
            guard let self = self else { return Observable.just(.success(Data())) }
            return self.network.getRequest(with: url)
        }, forKey: url).map { NetworkService.toString($0) }
    }

    func postRequest(with parameters: Network.PostParameters) -> Observable<NetworkServiceResult> {
        let key = postRequestKey(parameters)
        return cache.run({ [weak self] in
            guard let self = self else { return Observable.just(.success(Data())) }
            return self.network.postRequest(with: parameters)
        }, forKey: key).map { NetworkService.toString($0) }
    }

    private func postRequestKey(_ parameters: Network.PostParameters) -> String {
        var res = parameters.url
        if let body = parameters.parameters?.0 {
            res += body
        }
        return res
    }

    private static func toString(_ result: CacheServiceResult) -> NetworkServiceResult {
        switch result {
        case let .success(data):
            return .success(String(data: data, encoding: .utf8) ?? "")
        case let .failure(error):
            return .failure(error)
        }
    }
}
