//
//  GetLanguageSettingsUseCaseTests.swift
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

class GetLanguageSettingsUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)
    
    func testExecute() {
        // Arrange
        let testValue = "test"
        let outputLanguage = scheduler.createObserver(SettingsRepositoryLanguageResult.self)
        let useCase = GetLanguageSettingsUseCase(repository: createMockSettingsRepository(testValue))
        let res = useCase.execute(with: ())
        res.bind(to: outputLanguage)
            .disposed(by: disposeBag)

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputLanguage.events, [
            .next(0, .success(Language(name: testValue, code: testValue)))
        ])
    }
    
    private func createMockSettingsRepository(_ testValue: String) -> MockSettingsRepository {
        let mock = MockSettingsRepository()
        stub(mock) { stub in
            when(stub.getLanguage()).then { _ in
                return .just(.success(Language(name: testValue, code: testValue)))
            }
            when(stub.getLanguageBehaviour()).then { _ -> PublishSubject<Language> in
                return PublishSubject<Language>()
            }
        }
        return mock
    }
}
