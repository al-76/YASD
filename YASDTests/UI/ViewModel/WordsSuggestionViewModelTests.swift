//
//  WordsSuggestionViewModelTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 22.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//
@testable import YASD

import Cuckoo
import RxCocoa
import RxSwift
import RxTest
import XCTest

class WordsSuggestionViewModelTests: XCTestCase {
    enum TestError: Error {
        case someError
    }

    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    func testGetSuggestion() {
        // Arrange
        let testValue = "test"
        let inputSearch = scheduler.createHotObservable([
            .next(150, "error"),
            .next(160, "rx_error"),
            .next(200, testValue)
        ]).asDriver(onErrorJustReturn: "")
        let outputSuggestions = scheduler.createObserver(SuggestionItemResult.self)
        let viewModel = WordsSuggestionViewModel(getSuggestion: createMockGetAddSuggestionUseCase(),
                                                 addSuggestion: MockFactory
                                                    .createUseCaseStub(),
                                                 removeSuggestion: MockFactory
                                                    .createUseCaseStub())
        let input = WordsSuggestionViewModel.Input(search: inputSearch,
                                                   addHistory: Driver.never(),
                                                   removeHistory: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.suggestions.drive(outputSuggestions)
        )

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputSuggestions.events, [
            .next(150, .failure(TestError.someError)),
            .next(160, .failure(TestError.someError)),
            .next(200, .success([SuggestionItem(suggestion: testValue, removable: false)]))
        ])
    }

    func testAddSuggestion() {
        // Arrange
        let testValue = "test"
        let inputAddHistory = scheduler.createHotObservable([
            .next(150, "error"),
            .next(160, "rx_error"),
            .next(200, testValue)
        ]).asDriver(onErrorJustReturn: "")
        let outputSuggestions = scheduler.createObserver(SuggestionItemResult.self)
        let viewModel = WordsSuggestionViewModel(getSuggestion: MockFactory
                                                    .createUseCaseStub(),
                                                 addSuggestion: createMockGetAddSuggestionUseCase(),
                                                 removeSuggestion: MockFactory
                                                    .createUseCaseStub())
        let input = WordsSuggestionViewModel.Input(search: Driver.never(),
                                                   addHistory: inputAddHistory,
                                                   removeHistory: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.suggestions.drive(outputSuggestions)
        )

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputSuggestions.events, [
            .next(150, .failure(TestError.someError)),
            .next(160, .failure(TestError.someError)),
            .next(200, .success([SuggestionItem(suggestion: testValue, removable: false)]))
        ])
    }

    func testRemoveSuggestion() {
        // Arrange
        let testValue = "test"
        let inputRemoveHistory = scheduler.createHotObservable([
            .next(150, "error"),
            .next(160, "rx_error"),
            .next(200, testValue)
        ]).asDriver(onErrorJustReturn: "")
        let inputSearch = scheduler.createHotObservable([
            .next(145, "error"),
            .next(155, "rx_error"),
            .next(195, testValue)
        ]).asDriver(onErrorJustReturn: "")
        let outputSuggestions = scheduler.createObserver(SuggestionItemResult.self)
        let viewModel = WordsSuggestionViewModel(getSuggestion: createMockGetAddSuggestionUseCase(),
                                                 addSuggestion: createMockGetAddSuggestionUseCase(),
                                                 removeSuggestion: createMockRemoveSuggestionUseCase())
        let input = WordsSuggestionViewModel.Input(search: inputSearch,
                                                   addHistory: Driver.never(),
                                                   removeHistory: inputRemoveHistory)
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.suggestions.drive(outputSuggestions)
        )

        // Act
        scheduler.start()

        // Assert
        let expected = SuggestionItemResult.success([SuggestionItem(suggestion: testValue, removable: false)])
        XCTAssertEqual(outputSuggestions.events, [
            .next(145, .failure(TestError.someError)),
            .next(150, .failure(TestError.someError)),
            .next(155, .failure(TestError.someError)),
            .next(160, .failure(TestError.someError)),
            .next(195, expected),
            .next(200, expected)
        ])
    }

    func createMockGetAddSuggestionUseCase() -> MockAnyUseCase<String, SuggestionItemResult> {
        return MockFactory.createMockUseCase { value in
            value == "error" ? TestError.someError : nil
        } onRxError: { value in
            value == "rx_error" ? .failure(TestError.someError) : nil
        } onSuccess: { value in
            .success([SuggestionItem(suggestion: value, removable: false)])
        }
    }

    func createMockRemoveSuggestionUseCase() -> MockAnyUseCase<String, StorageServiceResult> {
        return MockFactory.createMockUseCase { value in
            value == "error" ? TestError.someError : nil
        } onRxError: { value in
            value == "rx_error" ? .failure(TestError.someError) : nil
        } onSuccess: { _ in
            .success(true)
        }
    }
}
