//
//  GetSuggestionUseCaseTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 24.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Cuckoo

class GetSuggestionUseCaseTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    func testExecute() {
        // Arrange
        let testValue = "test"
        let outputItems = scheduler.createObserver(SuggestionItemResult.self)
        let useCase = GetSuggestionUseCase(suggestions: MockFactory.createMockDictionaryRepository(),
                                           settings: MockFactory.createMockSettingsRepository(PublishSubject<Language>()),
                                           history: MockFactory.createSuggestionStorageRepository(testValue))
        let res = useCase.execute(with: "")
        disposeBag.insert(
            res.bind(to: outputItems)
        )
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputItems.events, [
            .next(0, .success([SuggestionItem(suggestion: testValue, removable: true)])),
            .completed(0)
        ])
    }
}
