//
//  PlaySoundUseCaseTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 17.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Cuckoo

class PlaySoundUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)
    
    func testExecute() {
        // Arrange
        let outputPlayer = scheduler.createObserver(PlayerManagerResult.self)
        let useCase = PlaySoundUseCase(player: createMockPlayManager())
        let res = useCase.execute(with: "test")
        res.bind(to: outputPlayer)
            .disposed(by: disposeBag)

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputPlayer.events, [
            .next(0, .success(true)),
            .completed(0)
        ])
    }
    
    private func createMockPlayManager() -> MockPlayerManager {
        let mock = MockPlayerManager()
        stub(mock) { stub in
            when(stub.playSound(with: any())).then { _ in
                return .just(.success(true))
            }
        }
        return mock
    }
}
