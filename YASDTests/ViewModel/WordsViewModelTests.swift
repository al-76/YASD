//
//  WordsTableViewModelTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 16/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//
@testable import YASD

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Cuckoo

class WordsViewModelTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)
    
    func testSearchWord() {
        // Arrange
        let testValue = "test"
        let inputSearch = scheduler.createHotObservable([
            .next(150, "error"),
            .next(160, "rx_error"),
            .next(200, testValue)
        ]).asDriver(onErrorJustReturn: "")
        let outputFoundWord = scheduler.createObserver(FoundWordResult.self)
        let viewModel = WordsViewModel(searchWord: createMockSearchWordUseCase(),
                                       addBookmark: MockFactory.createUseCaseStub(),
                                       playSound: MockFactory.createUseCaseStub(),
                                       removeBookmark: MockFactory.createUseCaseStub())
        let output = viewModel.transform(from: WordsViewModel.Input(search: inputSearch,
                                                       playUrl: Driver.never(),
                                                       addBookmark: Driver.never(),
                                                       removeBookmark: Driver.never()))
        disposeBag.insert(
            output.foundWords.drive(outputFoundWord)
        )
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputFoundWord.events, [
            .next(150, .failure(TestError.someError)),
            .next(160, .failure(TestError.someError)),
            .next(200, .success([FoundWord(testValue)]))
        ])
    }
    
    private func createMockSearchWordUseCase() -> MockAnyUseCase<SearchWordUseCase.Input, FoundWordResult> {
        let mock = MockAnyUseCase(wrapped: MockUseCase<SearchWordUseCase.Input, FoundWordResult>())
        stub(mock) { stub in
            when(stub.execute(with: any())).then { value in
                if value.word == "error" {
                    return .error(TestError.someError)
                } else if value.word == "rx_error" {
                    return .just(.failure(TestError.someError))
                } else {
                    return .just(.success([FoundWord(value.word)]))
                }
            }
        }
        return mock
    }
}
