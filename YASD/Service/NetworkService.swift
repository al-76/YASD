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
    
    func getRequest(url: String) -> Observable<Data> {
        return cache.runAction(key: url, action: { [weak self] in
            guard let self = self else { return Observable.just(Data()) }
            return self.network.getRequest(url: url)
        })
    }
    
    func postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<Data> {
        let key = postRequestKey(url: url, parameters: parameters)
        return cache.runAction(key: key, action: { [weak self] in
            guard let self = self else { return Observable.just(Data()) }
            return self.network.postRequest(url: url, parameters: parameters)
        })
    }
    
    private func postRequestKey(url: String, parameters: (String?, [String: String]?)?) -> String {
        var res = url
        if let body = parameters?.0 {
            res += body
        }
        return res
    }
}
