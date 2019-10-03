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
    func postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<Data> {
        let request = createRequest(url: url, type: "POST", parameters: parameters)
        return executeRequest(request: request)
    }
    
    func getRequest(url: String) -> Observable<Data> {
        let request = createRequest(url: url, type: "GET", parameters: nil)
        return executeRequest(request: request)
    }
    
    private func createRequest(url: String, type: String, parameters: (body: String?, headers: [String: String]?)?) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = type
        if let body = parameters?.0 {
            request.httpBody = body.data(using: .utf8)
        }
        if let headers = parameters?.1 {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
    
    private func executeRequest(request: URLRequest) -> Observable<Data> {
        return URLSession.shared.rx
            .data(request: request)
            .retry(3)
            .share()
    }
}
