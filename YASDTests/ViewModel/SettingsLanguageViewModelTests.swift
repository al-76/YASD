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

    func testGetLanguage() {
        // Arrange
        let testLanguage = "test"
        let outputLanguage = createGetLanguageObserver(testLanguage)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputLanguage.events, [
            .next(0, testLanguage),
            .completed(0)
        ])
    }
    
    func testGetLanguageError() {
        // Arrange
        let outputLanguage = createGetLanguageObserver("error")
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputLanguage.events, [
            .next(0, Language.defaultLanguage.name),
            .completed(0)
        ])
    }
    
    private func createGetLanguageObserver(_ testLanguage: String) -> TestableObserver<String> {
        let viewModel = SettingsViewModel(getLanguage: createMockGetLanguage(testLanguage))
        let outputLanguage = scheduler.createObserver(String.self)
        let output = viewModel.transform(from: SettingsViewModel.Input())
        disposeBag.insert(
            output.selectedLanguage.drive(outputLanguage)
        )
        return outputLanguage
    }
    
    private func createMockGetLanguage(_ language: String) -> MockAnyUseCase<Void, String> {
        let mockGetLanguage = MockAnyUseCase(wrapped: MockUseCase<Void, String>())
        stub(mockGetLanguage) { stub in
            when(stub.execute(with: any())).then { _ in
                if language == "error" {
                    return Observable.error(TestError.someError)
                }
                return Observable.just(language)
            }
        }
        return mockGetLanguage
    }
}
