//
//  GetLanguageListSettingsUseCaseTests.swift
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

class GetLanguageListSettingsUseCaseTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)
    
    func testExecute() {
        // Arrange
        let testValue = "test"
        let outputLanguageItems = scheduler.createObserver(SettingsLanguageItemResult.self)
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
                return .just(
                    .success([SettingsLanguageItem(selected: true,
                                                   language: Language(name: value, code: value))]))
            }
        }
        return mock
    }
}
