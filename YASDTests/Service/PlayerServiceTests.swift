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
        let played = service.playSound(url: "test")
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
        let played = service!.playSound(url: "test")
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
        let scheduler = TestScheduler(initialClock: 0)
        let service = PlayerService(player: createMockPlayerError(),
                                    cache: createMockCacheService(),
                                    network: createMockNetwork())
        
        // Act
        let played = service.playSound(url: "test")
        let res = scheduler.start { played }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, .failure(TestError.someError)),
            .completed(200)
            ])
    }
    
    private func createMockCacheService() -> MockCacheService {
        let mock = MockCacheService(cache: MockDataCache(name: "test"))
        stub(mock) { stub in
            when(stub.runAction(key: any(), action: any())).then { _, action in
                return action()
            }
        }
        return mock
    }
    
    private func createMockNetwork() -> MockNetwork {
        let mock = MockNetwork()
        stub(mock) { stub in
            when(stub.getRequest(url: anyString())).thenReturn(Observable.just(Data()))
        }
        return mock
    }
    
    private func createMockPlayer() -> MockPlayer {
        let mock = MockPlayer()
        stub(mock) { stub in
            when(stub.play(data: any())).thenDoNothing()
        }
        return mock
    }
    
    private func createMockPlayerError() -> MockPlayer {
        let mock = MockPlayer()
        stub(mock) { stub in
            when(stub.play(data: any())).thenThrow(TestError.someError)
        }
        return mock
    }
}
