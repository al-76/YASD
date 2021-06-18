////
////  PlayerManagerTests.swift
////  YASDTests
////
////  Created by Vyacheslav Konopkin on 27/09/2019.
////  Copyright © 2019 yac. All rights reserved.
////
//@testable import YASD
//
//import XCTest
//import RxSwift
//import RxTest
//import Cuckoo
//
//class PlayerManagerTests: XCTestCase {
//    enum TestError: Error {
//        case someError
//    }
//    
//    func testPlaySound() {
//        // Arrange
//        let scheduler = TestScheduler(initialClock: 0)
//        let service = PlayerManagerImpl(player: createMockPlayer(),
//                                    cache: createMockCacheService(),
//                                    network: createMockNetwork())
//        
//        // Act
//        let played = service.playSound(with: "test")
//        let res = scheduler.start { played }
//        
//        // Assert
//        XCTAssertEqual(res.events, [
//            .next(200, .success(true)),
//            .completed(200)
//           ])
//    }
//    
//    func testPlaySoundSelfNil() {
//        // Arrange
//        let scheduler = TestScheduler(initialClock: 0)
//        var service: PlayerManager? = PlayerManagerImpl(player: createMockPlayer(),
//                                                    cache: createMockCacheService(),
//                                                    network: createMockNetwork())
//        
//        // Act
//        let played = service!.playSound(with: "test")
//        service = nil
//        let res = scheduler.start { played }
//        
//        // Assert
//        XCTAssertEqual(res.events, [
//            .next(200, .success(false)),
//            .completed(200)
//           ])
//    }
//    
//    func testPlaySoundPlayerError() {
//        // Arrange
//        let scheduler = TestScheduler(initialClock: 0)
//        let service = PlayerManagerImpl(player: createMockPlayerError(),
//                                    cache: createMockCacheService(),
//                                    network: createMockNetwork())
//        
//        // Act
//        let played = service.playSound(with: "test")
//        let res = scheduler.start { played }
//        
//        // Assert
//        XCTAssertEqual(res.events, [
//            .next(200, .failure(TestError.someError)),
//            .completed(200)
//           ])
//    }
//    
//    func testPlaySoundPlayerNetworkError() {
//        // Arrange
//        let scheduler = TestScheduler(initialClock: 0)
//        let service = PlayerManagerImpl(player: createMockPlayer(),
//                                    cache: createMockCacheService(),
//                                    network: createMockNetworkError())
//        
//        // Act
//        let played = service.playSound(with: "test")
//        let res = scheduler.start { played }
//        
//        // Assert
//        XCTAssertEqual(res.events, [
//            .next(200, .failure(TestError.someError)),
//            .completed(200)
//           ])
//    }
//    
//    private func createMockCacheService() -> MockCacheService {
//        let mock = MockCacheService(cache: MockDataCache(name: "test"))
//        stub(mock) { stub in
//            when(stub.run(any(), forKey: any())).then { action, _ in
//                return action().flatMap { Observable.just($0) }
//            }
//        }
//        return mock
//    }
//    
//    private func createMockNetwork() -> MockNetwork {
//        let mock = MockNetwork()
//        stub(mock) { stub in
//            when(stub.getRequest(with: anyString())).thenReturn(Observable.just(.success(Data())))
//        }
//        return mock
//    }
//    
//    private func createMockNetworkError() -> MockNetwork {
//        let mock = MockNetwork()
//        stub(mock) { stub in
//            when(stub.getRequest(with: anyString())).thenReturn(Observable.just(.failure(TestError.someError)))
//        }
//        return mock
//    }
//    
//    private func createMockPlayer() -> MockPlayer {
//        let mock = MockPlayer()
//        stub(mock) { stub in
//            when(stub.play(with: any())).thenDoNothing()
//        }
//        return mock
//    }
//    
//    private func createMockPlayerError() -> MockPlayer {
//        let mock = MockPlayer()
//        stub(mock) { stub in
//            when(stub.play(with: any())).thenThrow(TestError.someError)
//        }
//        return mock
//    }
//}
