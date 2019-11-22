//
//  WordsCellModelTests.swift
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

class WordsCellModelTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    let disposeBag = DisposeBag()

    func testPlay() {
        // Arrange
        let errorUrl = "error"
        let scheduler = TestScheduler(initialClock: 0)
        let inputUrls = scheduler.createHotObservable([
            .next(150, "some_url"),
            .next(200, "some_url_2"),
            .next(300, errorUrl),
            .completed(400)
            ])
        let playerService = createMockPlayerService(errorUrl: errorUrl)
        let played = scheduler.createObserver(PlayerServiceResult.self)
        let viewModel = WordsCellModel(player: playerService)
        viewModel.transform(input: WordsCellModel.Input(url: inputUrls.asDriver(onErrorJustReturn: "")))
            .played.drive(played)
            .disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(played.events, [
            .next(150, .success(true)),
            .next(200, .success(true)),
            .next(300, .failure(TestError.someError)),
            .completed(400)
            ])
    }
    
    func testPlayNilViewModel() {
        // Arrange
        let errorUrl = "error"
        let scheduler = TestScheduler(initialClock: 0)
        let inputUrls = scheduler.createHotObservable([
            .next(150, "some_url"),
            .next(200, "some_url_2"),
            .completed(400)
            ])
        let playerService = createMockPlayerService(errorUrl: errorUrl)
        let played = scheduler.createObserver(PlayerServiceResult.self)
        var viewModel: WordsCellModel? = WordsCellModel(player: playerService)
        viewModel?.transform(input: WordsCellModel.Input(url: inputUrls.asDriver(onErrorJustReturn: "")))
            .played.drive(played)
            .disposed(by: disposeBag)
        
        // Act
        viewModel = nil
        scheduler.start()
        
        // Assert
        XCTAssertEqual(played.events, [
            .next(150, .success(false)),
            .next(200, .success(false)),
            .completed(400)
        ])
    }
    
    func createMockPlayerService(errorUrl: String) -> MockPlayerService {
        let mock = MockPlayerService(player: MockPlayer(), cache: MockCacheService(cache: MockDataCache(name: "test")), network: MockNetwork())
        stub(mock) { stub in
            when(stub.playSound(url: anyString())).then { stringUrl in
                return Observable<PlayerServiceResult>.create {
                    observable in
                    if stringUrl == errorUrl {
                        observable.on(.error(TestError.someError))
                    } else {
                        observable.on(.next(.success(true)))
                    }
                    observable.on(.completed)
                    return Disposables.create {}
                }
            }
        }
        return mock
    }
}
