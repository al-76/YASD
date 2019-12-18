//
//  HistoryServiceTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 18.12.2019.
//  Copyright © 2019 yac. All rights reserved.
//
@testable import YASD

import XCTest
import RxSwift
import RxTest
import Cuckoo

class HistoryServiceTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    func testGet() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let testData = ["test1", "test2", "abcd"]
        let service = HistoryService(storage: TestStorage(testData))
        
        // Act
        let gotData = service.get(with: "test")
        let res = scheduler.start { gotData }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, SuggestionResult.success(["test1", "test2"])),
            .completed(200)
         ])
    }
    
    func testGetWithEmpty() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let testData = ["test1", "test2", "abcd"]
        let service = HistoryService(storage: TestStorage(testData))
        
        // Act
        let gotData = service.get(with: "")
        let res = scheduler.start { gotData }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, SuggestionResult.success(testData)),
            .completed(200)
         ])
    }
    
    func testGetWithNotExisted() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let testData = ["test1", "test2", "abcd"]
        let service = HistoryService(storage: TestStorage(testData))
        
        // Act
        let gotData = service.get(with: "något")
        let res = scheduler.start { gotData }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, SuggestionResult.success([])),
            .completed(200)
        ])
    }
   
    func testAdd() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let service = HistoryService(storage: TestStorage([]))
        
        // Act
        let added = service.add("test").flatMap { _ in
            return service.get(with: "")
        }
        let res = scheduler.start { added }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, SuggestionResult.success(["test"])),
            .completed(200)
        ])
    }
    
    func testAddWithError() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let service = HistoryService(storage: TestStorageError([]))
        
        // Act
        let added = service.add("test").flatMap { _ in
            return service.get(with: "")
        }
        let res = scheduler.start { added }
        
        // Assert
        XCTAssertEqual(res.events, [
            .error(200, TestError.someError)
        ])
    }
    
    func testRemove() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let service = HistoryService(storage: TestStorage(["test1", "test2", "test3"]))
        
        // Act
        let added = service.remove("test2").flatMap { _ in
            return service.get(with: "")
        }
        let res = scheduler.start { added }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, SuggestionResult.success(["test1", "test3"])),
            .completed(200)
        ])
    }
    
    func testRemoveWithError() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let service = HistoryService(storage: TestStorageError(["test1", "test2", "test3"]))
        
        // Act
        let added = service.remove("test2").flatMap { _ in
            return service.get(with: "")
        }
        let res = scheduler.start { added }
        
        // Assert
        XCTAssertEqual(res.events, [
            .error(200, TestError.someError)
        ])
    }
    
    class TestStorage: Storage {
        let data: [String]
        
        init(_ data: [String]) {
            self.data = data
        }

        override func get<T: Codable>(id: String, defaultObject: T) -> T {
            return data as! T
        }
        
        override func save<T>(id: String, object: T) throws where T : Decodable, T : Encodable {
        }
    }
    
    class TestStorageError: TestStorage {
        override func save<T>(id: String, object: T) throws where T : Decodable, T : Encodable {
            throw TestError.someError
        }
    }
}
