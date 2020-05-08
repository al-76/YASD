//
//  PlayerServiceTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 27/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//
@testable import YASD

import XCTest
import RxSwift
import RxTest
import Cuckoo

class PlayerServiceTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    func testPlaySound() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let service = PlayerService(player: createMockPlayer(),
                                    cache: createMockCacheService(),
                                    network: createMockNetwork())
        
        // Act
        let played = service.playSound(with: "test")
        let res = scheduler.start { played }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, .success(true)),
            .completed(200)
           ])
    }
    
    func testPlaySoundSelfNil() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        var service: PlayerService? = PlayerService(player: createMockPlayer(),
                                                    cache: createMockCacheService(),
                                                    network: createMockNetwork())
        
        // Act
        let played = service!.playSound(with: "test")
        service = nil
        let res = scheduler.start { played }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, .success(false)),
            .completed(200)
           ])
    }
    
    func testPlaySoundPlayerError() {
        // Arrange
        let testError = TestError.someError
        let scheduler = TestScheduler(initialClock: 0)
        let service = PlayerService(player: createMockPlayerError(testError),
                                    cache: createMockCacheService(),
                                    network: createMockNetwork())
        
        // Act
        let played = service.playSound(with: "test")
        let res = scheduler.start { played }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, .failure(testError)),
            .completed(200)
           ])
    }
    
    func testPlaySoundPlayerNetworkError() {
        // Arrange
        let testError = TestError.someError
        let scheduler = TestScheduler(initialClock: 0)
        let service = PlayerService(player: createMockPlayer(),
                                    cache: createMockCacheService(),
                                    network: createMockNetworkError(testError))
        
        // Act
        let played = service.playSound(with: "test")
        let res = scheduler.start { played }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, .failure(testError)),
            .completed(200)
           ])
    }
    
    private func createMockCacheService() -> MockCacheService {
        let mock = MockCacheService(cache: MockDataCache(name: "test"))
        stub(mock) { stub in
            when(stub.run(any(), forKey: any())).then { action, _ in
                return action().flatMap { Observable.just($0) }
            }
        }
        return mock
    }
    
    private func createMockNetwork() -> MockNetwork {
        let mock = MockNetwork()
        stub(mock) { stub in
            when(stub.getRequest(with: anyString())).thenReturn(Observable.just(.success(Data())))
        }
        return mock
    }
    
    private func createMockNetworkError(_ error: Error) -> MockNetwork {
        let mock = MockNetwork()
        stub(mock) { stub in
            when(stub.getRequest(with: anyString())).thenReturn(Observable.just(.failure(error)))
        }
        return mock
    }
    
    private func createMockPlayer() -> MockPlayer {
        let mock = MockPlayer()
        stub(mock) { stub in
            when(stub.play(with: any())).thenDoNothing()
        }
        return mock
    }
    
    private func createMockPlayerError(_ error: Error) -> MockPlayer {
        let mock = MockPlayer()
        stub(mock) { stub in
            when(stub.play(with: any())).thenThrow(error)
        }
        return mock
    }
}
