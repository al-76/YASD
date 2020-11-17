////
////  CacheServiceTests.swift
////  YASDTests
////
////  Created by Vyacheslav Konopkin on 02/10/2019.
////  Copyright © 2019 yac. All rights reserved.
////
//@testable import YASD
//
//import XCTest
//import RxSwift
//import RxTest
//import Cuckoo
//
//class CacheServiceTests: XCTestCase {
//    enum TestError: Error {
//        case someError
//    }
//        
//    func testRunActionNotCached() {
//        // Arrange
//        let testData = Data()
//        let service = CacheService(cache: createMockDataCache(data: nil))
//        let scheduler = TestScheduler(initialClock: 0)
//        
//        // Act
//        let runnedAction = service.run({ Observable.just(.success(testData)) }, forKey: "test")
//        let res = scheduler.start { runnedAction }
//        
//        // Assert
//        XCTAssertEqual(res.events, [
//            .next(200, .success(testData)),
//            .completed(200)
//       ])
//    }
//    
//    func testRunActionCached() {
//        // Arrange
//        let testData = Data()
//        let service = CacheService(cache: createMockDataCache(data: testData))
//        let scheduler = TestScheduler(initialClock: 0)
//        
//        // Act
//        let runnedAction = service.run({ Observable.just(.success(Data())) }, forKey: "test")
//        let res = scheduler.start { runnedAction }
//        
//        // Assert
//        XCTAssertEqual(res.events, [
//            .next(200, .success(testData)),
//            .completed(200)
//       ])
//    }
//    
//    func testRunActionSelfNil() {
//        // Arrange
//        let testData = Data()
//        var service: CacheService? = CacheService(cache: createMockDataCache(data: nil))
//        let scheduler = TestScheduler(initialClock: 0)
//        
//        // Act
//        let runnedAction = service!.run({ Observable.just(.success(testData)) }, forKey: "test")
//        service = nil
//        let res = scheduler.start { runnedAction }
//        
//        // Assert
//        XCTAssertEqual(res.events, [
//            .next(200, .success(testData)),
//            .completed(200)
//       ])
//    }
//    
//    func testRunActionError() {
//        // Arrange
//        let testError = TestError.someError
//        let service = CacheService(cache: createMockDataCache(data: nil))
//        let scheduler = TestScheduler(initialClock: 0)
//        
//        // Act
//        let runnedAction = service.run({ Observable.just(.failure(testError)) }, forKey: "test")
//        let res = scheduler.start { runnedAction }
//        
//        // Assert
//        XCTAssertEqual(res.events, [
//            .next(200, .failure(testError)),
//            .completed(200)
//        ])
//    }
//    
//    private func createMockDataCache(data: Data?) -> MockDataCache {
//        let mock = MockDataCache(name: "test")
//        stub(mock) { stub in
//            when(stub.load(any())).thenReturn(Observable.just(data))
//            when(stub.save(any(), forKey: any())).then { data, _ in
//                Observable.just(data)
//            }
//        }
//        return mock
//    }
//}
//
