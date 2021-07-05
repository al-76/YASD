//
//  GetLanguageListSettingsUseCaseTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 17.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import Cuckoo
import RxCocoa
import RxSwift
import RxTest
import XCTest

class GetLanguageListSettingsUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    func testExecute() {
        // Arrange
        let testValue = "test"
        let outputLanguageItems = scheduler.createObserver(SettingsRepositoryItemResult.self)
        let useCase = GetLanguageListSettingsUseCase(repository: createMockSettingsRepository())
        let res = useCase.execute(with: testValue)
        res.bind(to: outputLanguageItems)
            .disposed(by: disposeBag)

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputLanguageItems.events, [
            .next(0, .success([SettingsLanguageItem(selected: true,
                                                    language: Language(name: testValue, code: testValue))])),
            .completed(0)
        ])
    }

    private func createMockSettingsRepository() -> MockSettingsRepository {
        let mock = MockSettingsRepository()
        stub(mock) { stub in
            when(stub.getLanguageList(with: any())).then { value in
                .just(
                    .success([SettingsLanguageItem(selected: true,
                                                   language: Language(name: value, code: value))]))
            }
        }
        return mock
    }
}
