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
//    enum TestError: Error {
//        case someError
//    }

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
            when(stub.load(key: any())).thenReturn(Observable.just(data))
            when(stub.save(key: any(), data: any())).then { _, data in
                Observable.just(data)
            }
        }
        return mock
    }
    
//    func testSave() {
//        // Arrange
//        let testFile = URL(string: "test_file")!
//        let scheduler = TestScheduler(initialClock: 0)
//        let cache = DataCache(name: "test", files: createMockFiles(fileUrl: testFile))
//
//        // Act
//        let saved = cache.save(key: "test", data: Data())
//        let res = scheduler.start { saved }
//
//        // Assert
//        XCTAssertEqual(res.events, [
//            .next(200, testFile),
//            .completed(200)
//        ])
//    }
//
//    func testSaveError() {
//        // Arrange
//        let scheduler = TestScheduler(initialClock: 0)
//        let cache = DataCache(name: "test", files: createMockFilesError())
//
//        // Act
//        let saved = cache.save(key: "test", data: Data())
//        let res = scheduler.start { saved }
//
//        // Assert
//        XCTAssertEqual(res.events, [
//            .error(200, TestError.someError)
//        ])
//    }
//
//    func testLoadFirst() {
//        // Arrange
//        let scheduler = TestScheduler(initialClock: 0)
//        let cache = DataCache(name: "test", files: MockFiles())
//
//        // Act
//        let loaded = cache.load(key: "test")
//        let res = scheduler.start { loaded }
//
//        // Assert
//        XCTAssertEqual(res.events, [
//            .next(200, nil),
//            .completed(200)
//        ])
//    }
//
//    func testLoadSecond() {
//        // Arrange
//        let testKey = "test_key"
//        let testFile = URL(string: "test_file")!
//        let scheduler = TestScheduler(initialClock: 0)
//        let cache = DataCache(name: "test", files: createMockFiles(fileUrl: testFile))
//        let saved = cache.save(key: testKey, data: Data())
//        _ = scheduler.start { saved }
//
//        // Act
//        let loaded = cache.load(key: testKey)
//        let resLoaded = scheduler.start { loaded }
//
//        // Assert
//        XCTAssertEqual(resLoaded.events, [
//            .next(1000, testFile),
//            .completed(1000)
//        ])
//    }
//
//    func createMockFiles(fileUrl: URL) -> MockFiles {
//        let mock = MockFiles()
//        stub(mock) { stub in
//            stub.createTempFile(name: any()).thenReturn(fileUrl)
//            stub.writeData(to: any(), data: any()).thenDoNothing()
//        }
//        return mock
//    }
//
//    func createMockFilesError() -> MockFiles {
//        let mock = MockFiles()
//        stub(mock) { stub in
//            stub.createTempFile(name: any()).thenThrow(TestError.someError)
//            stub.writeData(to: any(), data: any()).thenThrow(TestError.someError)
//        }
//        return mock
//    }
}

