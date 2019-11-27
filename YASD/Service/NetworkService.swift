//
//  NetworkService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 03/10/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import Foundation

class NetworkService {
    private let cache: CacheService
    private let network: Network
    
    init(cache: CacheService, network: Network) {
        self.cache = cache
        self.network = network
    }
    
    func getRequest(with url: String) -> Observable<String> {
        return cache.run({ [weak self] in
            guard let self = self else { return Observable.just(Data()) }
            return self.network.getRequest(with: url)
            }, forKey: url).map { NetworkService.toString($0) }
    }
    
    func postRequest(with parameters: Network.PostParameters) -> Observable<String> {
        let key = postRequestKey(parameters)
        return cache.run({ [weak self] in
            guard let self = self else { return Observable.just(Data()) }
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
    
    private static func toString(_ data: Data) -> String {
        return String(data: data, encoding: .utf8) ?? ""
    }
}
