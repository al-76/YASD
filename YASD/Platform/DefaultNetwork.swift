//
//  DefaultNetwork.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 31/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import Foundation

class DefaultNetwork: Network {
    enum DefaultNetworkError: Error {
        case noContext
        case invalidUrl(url: String)
    }
    
    private typealias URLRequestResult = Result<URLRequest>
    
    func postRequest(with parameters: PostParameters) -> Observable<NetworkResult> {
        return createRequest(parameters.url, type: "POST", parameters: parameters.parameters)
            .flatMap { [weak self] request -> Observable<NetworkResult> in
                guard let self = self else { return Observable.just(.success(Data())) }
                return self.execute(request)
        }
    }
    
    func getRequest(with url: String) -> Observable<NetworkResult> {
        return createRequest(url, type: "GET", parameters: nil)
            .flatMap { [weak self] request -> Observable<NetworkResult>in
                guard let self = self else { return Observable.just(.success(Data())) }
                return self.execute(request)
        }
    }
    
    private func createRequest(_ stringUrl: String, type: String, parameters: Parameters) -> Observable<URLRequestResult> {
        return Observable<URLRequestResult>.create { [weak self] observer in
            if let self = self {
                do {
                    let request = try self.createRequestAction(stringUrl, type, parameters)
                    observer.onNext(.success(request))
                } catch let error {
                    observer.onNext(.failure(error))
                }
            } else {
                observer.onNext(.failure(DefaultNetworkError.noContext))
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    private func createRequestAction(_ stringUrl: String, _ type: String, _ parameters: Parameters) throws -> URLRequest {
        guard let url = URL(string: stringUrl) else { throw DefaultNetworkError.invalidUrl(url: stringUrl) }
        var request = URLRequest(url: url)
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
    
    private func execute(_ result: URLRequestResult) -> Observable<NetworkResult> {
        switch result {
        case let .success(request):
            return URLSession.shared.rx
                .data(request: request)
                .retry(3)
                .share()
                .map { .success($0) }
        case let .failure(error):
            return Observable.just(.failure(error))
        }
    }
}

extension DefaultNetwork.DefaultNetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noContext:
            return NSLocalizedString("No context", comment: "")
        case let .invalidUrl(url):
            return NSLocalizedString("Invalid url: " + url, comment: "")
        }
    }
}
