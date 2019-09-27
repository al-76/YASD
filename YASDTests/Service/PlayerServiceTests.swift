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
    
    func testPlaySoundFromNetwork() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let service = PlayerService(player: createMockPlayer(),
                                    cache: createMockDataCache(empty: true),
                                    network: createMockNetwork())
        
        // Act
        let played = service.playSound(stringUrl: "test")
        let res = scheduler.start { played }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, .success(true)),
            .completed(200)
            ])
    }
    
    func testPlaySoundFromCache() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let service = PlayerService(player: createMockPlayer(),
                                    cache: createMockDataCache(empty: false),
                                    network: MockNetwork())
        
        // Act
        let played = service.playSound(stringUrl: "test")
        let res = scheduler.start { played }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, .success(true)),
            .completed(200)
            ])

    }
    
    func testPlaySoundInvalidUrl() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let service = PlayerService(player: MockPlayer(), cache: createMockDataCache(empty: false), network: Network())
        
        // Act
        let played = service.playSound(stringUrl: "")
        let res = scheduler.start { played }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, .success(false)),
            .completed(200)
            ])
    }
    
    func testPlaySoundSelfNil() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        var service: PlayerService? = PlayerService(player: createMockPlayer(),
                                    cache: createMockDataCache(empty: true),
                                    network: createMockNetwork())
        
        // Act
        let played = service!.playSound(stringUrl: "test")
        service = nil
        let res = scheduler.start { played }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, .failure(PlayerServiceError.selfIsNil)),
            .completed(200)
            ])
    }
    
    private func createMockDataCache(empty: Bool) -> MockDataCache {
        let testUrl = URL(string: "test")
        let mock = MockDataCache(name: "test", files: MockFiles())
        stub(mock) { stub in
            stub.load(key: anyString()).thenReturn(Observable.just(empty ? nil : testUrl))
            stub.save(key: anyString(), data: any()).thenReturn(Observable.just(testUrl!))
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
            when(stub.play(url: any())).thenDoNothing()
        }
        return mock
    }
}
