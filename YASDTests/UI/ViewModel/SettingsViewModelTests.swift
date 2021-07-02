//
//  SettingsViewModel.swift
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

class SettingsViewModelTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    func testGetLanguage() {
        // Arrange
        let testLanguage = "test"
        let viewModel = SettingsViewModel(getLanguage: createMockGetStringUseCase(testLanguage),
                                          getHistorySize: createMockGetStringUseCase(""),
                                          getCacheSize: createMockGetStringUseCase(""),
                                          clearHistory: MockFactory.createUseCaseStub(),
                                          clearCache: MockFactory.createUseCaseStub())
        let outputLanguage = scheduler.createObserver(String.self)
        let input = SettingsViewModel.Input(clearHistory: Driver.never(),
                                            clearCache: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.selectedLanguage.drive(outputLanguage)
        )
        
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
        let viewModel = SettingsViewModel(getLanguage: createMockGetStringUseCase("error"),
                                          getHistorySize: createMockGetStringUseCase(""),
                                          getCacheSize: createMockGetStringUseCase(""),
                                          clearHistory: MockFactory.createUseCaseStub(),
                                          clearCache: MockFactory.createUseCaseStub())
        let outputLanguage = scheduler.createObserver(String.self)
        let input = SettingsViewModel.Input(clearHistory: Driver.never(),
                                            clearCache: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.selectedLanguage.drive(outputLanguage)
        )
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputLanguage.events, [
            .next(0, Language.defaultLanguage.name),
            .completed(0)
        ])
    }
    
    func testGetHistorySize() {
        // Arrange
        let testValue = "test"
        let viewModel = SettingsViewModel(getLanguage: createMockGetStringUseCase(""),
                                          getHistorySize: createMockGetStringUseCase(testValue),
                                          getCacheSize: createMockGetStringUseCase(""),
                                          clearHistory: MockFactory.createUseCaseStub(),
                                          clearCache: MockFactory.createUseCaseStub())
        let outputHistorySize = scheduler.createObserver(String.self)
        let input = SettingsViewModel.Input(clearHistory: Driver.never(),
                                            clearCache: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.historySize.drive(outputHistorySize)
        )
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputHistorySize.events, [
            .next(0, testValue)
        ])
    }
    
    func testGetHistorySizeError() {
        // Arrange
        let viewModel = SettingsViewModel(getLanguage: createMockGetStringUseCase(""),
                                          getHistorySize: createMockGetStringUseCase("error"),
                                          getCacheSize: createMockGetStringUseCase(""),
                                          clearHistory: MockFactory.createUseCaseStub(),
                                          clearCache: MockFactory.createUseCaseStub())
        let outputHistorySize = scheduler.createObserver(String.self)
        let input = SettingsViewModel.Input(clearHistory: Driver.never(),
                                            clearCache: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.historySize.drive(outputHistorySize)
        )
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputHistorySize.events, [
            .next(0, "")
        ])
    }
    
    func testGetCacheSize() {
        // Arrange
        let testValue = "test"
        let viewModel = SettingsViewModel(getLanguage: createMockGetStringUseCase(""),
                                          getHistorySize: createMockGetStringUseCase(""),
                                          getCacheSize: createMockGetStringUseCase(testValue),
                                          clearHistory: MockFactory.createUseCaseStub(),
                                          clearCache: MockFactory.createUseCaseStub())
        let outputCacheSize = scheduler.createObserver(String.self)
        let input = SettingsViewModel.Input(clearHistory: Driver.never(),
                                            clearCache: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.cacheSize.drive(outputCacheSize)
        )
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputCacheSize.events, [
            .next(0, testValue)
        ])
    }
    
    func testGetCacheSizeError() {
        // Arrange
        let viewModel = SettingsViewModel(getLanguage: createMockGetStringUseCase(""),
                                          getHistorySize: createMockGetStringUseCase(""),
                                          getCacheSize: createMockGetStringUseCase("error"),
                                          clearHistory: MockFactory.createUseCaseStub(),
                                          clearCache: MockFactory.createUseCaseStub())
        let outputCacheSize = scheduler.createObserver(String.self)
        let input = SettingsViewModel.Input(clearHistory: Driver.never(),
                                            clearCache: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.cacheSize.drive(outputCacheSize)
        )
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputCacheSize.events, [
            .next(0, "")
        ])
    }
    
    func testClearHistory() {
        let testValue = "test"
        let inputClearHistory = scheduler.createHotObservable([.next(150, ())])
            .asDriver(onErrorJustReturn: ())
        let viewModel = SettingsViewModel(getLanguage: createMockGetStringUseCase(""),
                                          getHistorySize: createMockGetStringUseCase(testValue),
                                          getCacheSize: createMockGetStringUseCase(""),
                                          clearHistory: createMockClearHistoryUseCase(),
                                          clearCache: MockFactory.createUseCaseStub())
        let outputHistorySize = scheduler.createObserver(String.self)
        let input = SettingsViewModel.Input(clearHistory: inputClearHistory,
                                            clearCache: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.historySize.drive(outputHistorySize)
        )
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputHistorySize.events, [
            .next(0, testValue),
            .next(150, testValue)
        ])
    }
    
    func testClearCache() {
        let testValue = "test"
        let inputClearCache = scheduler.createHotObservable([.next(150, ())])
            .asDriver(onErrorJustReturn: ())
        let viewModel = SettingsViewModel(getLanguage: createMockGetStringUseCase(""),
                                          getHistorySize: createMockGetStringUseCase(""),
                                          getCacheSize: createMockGetStringUseCase(testValue),
                                          clearHistory: MockFactory.createUseCaseStub(),
                                          clearCache: createMockClearCacheUseCase())
        let outputCacheSize = scheduler.createObserver(String.self)
        let input = SettingsViewModel.Input(clearHistory: Driver.never(),
                                            clearCache: inputClearCache)
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.cacheSize.drive(outputCacheSize)
        )
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputCacheSize.events, [
            .next(0, testValue),
            .next(150, testValue)
        ])
    }
    
    private func createMockGetStringUseCase(_ value: String) -> MockAnyUseCase<Void, String> {
        return MockFactory.createMockUseCase { _ in
            value == "error" ? TestError.someError : nil
        } onRxError: { _ in
            nil
        } onSuccess: { _ in
            value
        }
    }
    
    private func createMockClearCacheUseCase() -> MockAnyUseCase<Void, Bool> {
        return MockFactory.createMockUseCase { _ in
            nil
        } onRxError: { _ in
            nil
        } onSuccess: { _ in
            true
        }
    }
    
    private func createMockClearHistoryUseCase() -> MockAnyUseCase<Void, StorageServiceResult> {
        return MockFactory.createMockUseCase { _ in
            nil
        } onRxError: { _ in
            nil
        } onSuccess: { _ in
            .success(true)
        }
    }
}

