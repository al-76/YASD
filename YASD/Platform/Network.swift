//
//  Network.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 31/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import Foundation

class Network {
    typealias PostParameters = (url: String, parameters: (String?, [String: String]?)?)
    func postRequest(with parameters: PostParameters) -> Observable<Data> {
        let request = createRequest(parameters.url, type: "POST", parameters: parameters.parameters)
        return execute(request)
    }
    
    func getRequest(with url: String) -> Observable<Data> {
        let request = createRequest(url, type: "GET", parameters: nil)
        return execute(request)
    }
    
    private func createRequest(_ url: String, type: String, parameters: (body: String?, headers: [String: String]?)?) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = type
        if let body = parameters?.0 {
            request.httpBody = body.data(using: .utf8)
        }
        if let parameters = parameters?.1 {
            for (key, value) in parameters {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
    
    private func execute(_ request: URLRequest) -> Observable<Data> {
        return URLSession.shared.rx
            .data(request: request)
            .retry(3)
            .share()
    }
}
