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
        let expectedValue = SettingsLanguageItemResult
            .success([SettingsLanguageItem(selected: false, language: Language(name: testValue, code: testValue))])
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
        let outputLanguageList = scheduler.createObserver(SettingsLanguageItemResult.self)
        let viewModel = SettingsLanguageViewModel(getLanguageList: createMockGetLanguageListUseCase(), updateLanguage: createMockUpdateLanguageUseCase())
        let input = SettingsLanguageViewModel.Input(search: inputSearch,
                                                    select: inputSelect)
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.languages.drive(outputLanguageList)
        )
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputLanguageList.events, [
            .next(150, .failure(TestError.someError)),
            .next(160, .failure(TestError.someError)),
            .next(200, expectedValue),
            .next(450, expectedValue),
            .next(500, expectedValue),
            .completed(600)
        ])
    }
    
    private func createMockGetLanguageListUseCase() -> MockAnyUseCase<String, SettingsLanguageItemResult> {
        return MockFactory.createMockUseCase { value in
            value == "error" ? TestError.someError : nil
        } onRxError: { value in
            value == "rx_error" ? .failure(TestError.someError) : nil
        } onSuccess: { value in
            .success([SettingsLanguageItem(selected: false, language: Language(name: value, code: value))])
        }
    }
    
    private func createMockUpdateLanguageUseCase() -> MockAnyUseCase<String, Bool> {
        return MockFactory.createMockUseCase { value in
            value == "error" ? TestError.someError : nil
        } onRxError: { value in
            nil
        } onSuccess: { value in
            true
        }
    }
}
