//
//  SettingsLanguageViewModelTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 05/08/2019.
//  Copyright © 2019 yac. All rights reserved.
//

@testable import YASD

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Cuckoo

class SettingsLanguageViewModelTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    func testSearchAndSelectLanguage() {
        // Arrange
        let testValue = "test"
        let expectedValue = [SettingsLanguageItem(selected: false, language: Language(name: testValue, code: testValue))]
        let inputSearch = scheduler.createHotObservable([
            .next(150, "error"),
            .next(160, "rx_error"),
            .next(200, testValue),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let inputSelect = scheduler.createHotObservable([
            .next(450, "error"),
            .next(500, testValue),
            .completed(600)
        ]).asDriver(onErrorJustReturn: "")
        let outputLanguageList = scheduler.createObserver([SettingsLanguageItem].self)
        let viewModel = SettingsLanguageViewModel(getLanguageList: createMockGetLanguageListUseCase(), updateLanguage: createMockUpdateLanguageUseCase())
        let output = viewModel.transform(from: SettingsLanguageViewModel.Input(search: inputSearch, select: inputSelect))
        disposeBag.insert(
            output.languages.drive(outputLanguageList)
        )
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputLanguageList.events, [
            .next(150, []),
            .next(160, []),
            .next(200, expectedValue),
            .next(450, expectedValue),
            .next(500, expectedValue),
            .completed(600)
        ])
    }
    
    private func createMockGetLanguageListUseCase() -> MockAnyUseCase<String, SettingsLanguageItemResult> {
        let mock = MockAnyUseCase(wrapped: MockUseCase<String, SettingsLanguageItemResult>())
        stub(mock) { stub in
            when(stub.execute(with: any())).then { value in
                if value == "rx_error" {
                    return .error(TestError.someError)
                } else if value == "error" {
                    return .just(.failure(TestError.someError))
                } else {
                    return .just(.success([SettingsLanguageItem(selected: false, language: Language(name: value, code: value))]))
                }
            }
        }
        return mock
    }
    
    private func createMockUpdateLanguageUseCase() -> MockAnyUseCase<String, Void> {
        let mock = MockAnyUseCase(wrapped: MockUseCase<String, Void>())
        stub(mock) { stub in
            when(stub.execute(with: any())).then { value in
                if value == "error" {
                    return .error(TestError.someError)
                } else {
                    return .just(())
                }
            }
        }
        return mock
    }
}
