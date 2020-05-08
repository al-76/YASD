//
//  NetworkServiceTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 25.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//
@testable import YASD

import XCTest
import RxSwift
import RxTest
import Cuckoo

class NetworkServiceTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    func testGetRequestCached() {
        let str = "Test"
        let strData = str.data(using: String.Encoding.utf8)!
        testRequest(with: str,
                       cache: createCacheServiceMock(value: strData, cached: true),
                       network: NetworkStub(),
                       action: { $0.getRequest(with: "test") })
    }
    
    func testGetRequestNotCached() {
        let str = "Test"
        let strData = str.data(using: String.Encoding.utf8)!
        testRequest(with: str,
                       cache: createCacheServiceMock(value: strData, cached: false),
                       network: createNetworkMock(strData),
                       action: { $0.getRequest(with: "test") })
    }
    
    func testPostRequestCached() {
        let str = "Test"
        let strData = str.data(using: String.Encoding.utf8)!
        let parameters = Network.PostParameters(url: "test", parameters: ("test", ["key": "value"]))
        testRequest(with: str,
                         cache: createCacheServiceMock(value: strData, cached: true),
                         network: NetworkStub(),
                         action: { $0.postRequest(with: parameters) })
    }
    
    func testPostRequestNotCached() {
        let str = "Test"
        let strData = str.data(using: String.Encoding.utf8)!
        let parameters = Network.PostParameters(url: "test", parameters: ("test", ["key": "value"]))
        testRequest(with: str,
                       cache: createCacheServiceMock(value: strData, cached: false),
                       network: createNetworkMock(strData),
                       action: { $0.postRequest(with: parameters) })
    }
    
    func testGetRequestWithInvalidService() {
        testRequestsWithInvalidObject(with: { service in
            return service.postRequest(with: Network.PostParameters(url: "test", parameters: nil))
        })
    }
    
    func testPostRequestWithInvalidService() {
        testRequestsWithInvalidObject(with: { service in
            return service.getRequest(with: "test")
        })
    }
    
    func testGetRequestError() {
        testRequestError(cache: createCacheServiceMock(value: Data(), cached: false),
                       network: createNetworkMockError(),
                       action: { $0.getRequest(with: "test") })
    }
    
    func testPostRequestError() {
        testRequestError(cache: createCacheServiceMock(value: Data(), cached: false),
                       network: createNetworkMockError(),
                       action: { $0.postRequest(with: Network.PostParameters(url: "test", parameters: nil)) })
    }
    
    private func testRequestsWithInvalidObject(with request: (NetworkService) -> Observable<NetworkServiceResult>) {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        var service: NetworkService? = NetworkService(cache: createCacheServiceNotCachedMock(value: "Test".data(using: String.Encoding.utf8)!),
                                     network: NetworkStub())
        let executed = request(service!)
               
        // Act
        service = nil
        let res = scheduler.start { executed }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, .success("")),
            .completed(200)
       ])
    }
    
    private func testRequest(with testData: String, cache: CacheService, network: Network, action: (NetworkService) -> Observable<NetworkServiceResult>) {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let service = NetworkService(cache: cache, network: network)
        
        // Act
        let executed = action(service)
        let res = scheduler.start { executed }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, .success(testData)),
            .completed(200)
        ])
    }
    
    private func testRequestError(cache: CacheService, network: Network, action: (NetworkService) -> Observable<NetworkServiceResult>) {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let service = NetworkService(cache: cache, network: network)
        
        // Act
        let executed = action(service)
        let res = scheduler.start { executed }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, .failure(TestError.someError)),
            .completed(200)
        ])
    }
        
    func createCacheServiceMock(value: Data, cached: Bool) -> MockCacheService {
        let mock = MockCacheService(cache: DataCacheStub(name: "Test"))
        stub(mock) { stub in
            when(stub.run(any(), forKey: any())).then { action, key in
                if !cached {
                    return action()
                }
                return Observable.just(.success(value))
            }
        }
        return mock
    }
    
    func createCacheServiceNotCachedMock(value: Data) -> MockCacheService {
        let mock = MockCacheService(cache: DataCacheStub(name: "Test"))
        stub (mock) { stub in
            when(stub.run(any(), forKey: any())).then { action, key in
                return Observable<Data>.create { observable in
                    observable.on(.next(value))
                    observable.onCompleted()
                    return Disposables.create {}
                }.flatMap { _ in action() }
            }
        }
        return mock
    }
    
    func createNetworkMock(_ value: Data) -> MockNetwork {
        let mock = MockNetwork()
        stub(mock) { stub in
            when(stub.getRequest(with: any())).thenReturn(Observable.just(.success(value)))
            when(stub.postRequest(with: any())).thenReturn(Observable.just(.success(value)))
        }
        return mock
    }
    
    func createNetworkMockError() -> MockNetwork {
        let mock = MockNetwork()
        stub(mock) { stub in
            when(stub.getRequest(with: any())).thenReturn(Observable.just(.failure(TestError.someError)))
            when(stub.postRequest(with: any())).thenReturn(Observable.just(.failure(TestError.someError)))
        }
        return mock
    }
}
