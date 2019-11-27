//
//  CacheServiceTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 02/10/2019.
//  Copyright © 2019 yac. All rights reserved.
//
@testable import YASD

import XCTest
import RxSwift
import RxTest
import Cuckoo

class CacheServiceTests: XCTestCase {
    func testRunActionNotCached() {
        // Arrange
        let testData = Data()
        let service = CacheService(cache: createMockDataCache(data: nil))
        let scheduler = TestScheduler(initialClock: 0)
        
        // Act
        let runnedAction = service.runAction(key: "test", action: { Observable.just(testData) })
        let res = scheduler.start { runnedAction }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, testData),
            .completed(200)
       ])
    }
    
    func testRunActionCached() {
        // Arrange
        let testData = Data()
        let service = CacheService(cache: createMockDataCache(data: testData))
        let scheduler = TestScheduler(initialClock: 0)
        
        // Act
        let runnedAction = service.runAction(key: "test", action: { Observable.just(Data()) })
        let res = scheduler.start { runnedAction }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, testData),
            .completed(200)
       ])
    }
    
    func testRunActionSelfNil() {
        // Arrange
        let testData = Data()
        var service: CacheService? = CacheService(cache: createMockDataCache(data: nil))
        let scheduler = TestScheduler(initialClock: 0)
        
        // Act
        let runnedAction = service!.runAction(key: "test", action: { Observable.just(testData) })
        service = nil
        let res = scheduler.start { runnedAction }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, testData),
            .completed(200)
       ])
    }
    
    private func createMockDataCache(data: Data?) -> MockDataCache {
        let mock = MockDataCache(name: "test")
        stub(mock) { stub in
            when(stub.load(any())).thenReturn(Observable.just(data))
            when(stub.save(any(), forData: any())).then { _, data in
                Observable.just(data)
            }
        }
        return mock
    }
}

