//
//  UpdateLanguageSettingsUseCaseTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 18.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Cuckoo

class UpdateLanguageSettingsUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)
    
    func testExecute() {
        // Arrange
        let testValue = "test"
        let outputSetLanguage = scheduler.createObserver(Bool.self)
        let useCase = UpdateLanguageSettingsUseCase(repository: createMockSettingsRepository())
        let res = useCase.execute(with: testValue)
        res.bind(to: outputSetLanguage)
            .disposed(by: disposeBag)

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputSetLanguage.events, [
            .next(0, true),
            .completed(0)
        ])
    }
    
    private func createMockSettingsRepository() -> MockSettingsRepository {
        let mock = MockSettingsRepository()
        stub(mock) { stub in
            when(stub.setLanguage(any())).then { _ in
                return .just(())
            }
        }
        return mock
    }
}
