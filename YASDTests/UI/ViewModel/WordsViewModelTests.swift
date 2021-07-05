//
//  WordsTableViewModelTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 16/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//
@testable import YASD

import Cuckoo
import RxCocoa
import RxSwift
import RxTest
import XCTest

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
        let input = WordsViewModel.Input(search: inputSearch,
                                         playUrl: Driver.never(),
                                         addBookmark: Driver.never(),
                                         removeBookmark: Driver.never())
        let output = viewModel.transform(from: input)
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

    func testAddBookmark() {
        // Arrange
        let inputBookmarks = scheduler.createHotObservable([
            .next(150, FormattedWord("error")),
            .next(160, FormattedWord("rx_error")),
            .next(200, FormattedWord("test"))
        ]).asDriver(onErrorJustReturn: FormattedWord(""))
        let outputBookmarks = scheduler.createObserver(StorageServiceResult.self)
        let viewModel = WordsViewModel(searchWord: MockFactory.createUseCaseStub(),
                                       addBookmark: createMockBookmarkUseCase(),
                                       playSound: MockFactory.createUseCaseStub(),
                                       removeBookmark: MockFactory.createUseCaseStub())
        let input = WordsViewModel.Input(search: Driver.never(),
                                         playUrl: Driver.never(),
                                         addBookmark: inputBookmarks,
                                         removeBookmark: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.bookmarked.drive(outputBookmarks)
        )

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputBookmarks.events, [
            .next(150, .failure(TestError.someError)),
            .next(160, .failure(TestError.someError)),
            .next(200, .success(true))
        ])
    }

    func testPlaySound() {
        // Arrange
        let inputUrl = scheduler.createHotObservable([
            .next(150, "error"),
            .next(160, "rx_error"),
            .next(200, "test")
        ]).asDriver(onErrorJustReturn: "")
        let outputPlayed = scheduler.createObserver(PlayerManagerResult.self)
        let viewModel = WordsViewModel(searchWord: MockFactory.createUseCaseStub(),
                                       addBookmark: MockFactory.createUseCaseStub(),
                                       playSound: createMockPlaySoundUseCase(),
                                       removeBookmark: MockFactory.createUseCaseStub())
        let input = WordsViewModel.Input(search: Driver.never(),
                                         playUrl: inputUrl,
                                         addBookmark: Driver.never(),
                                         removeBookmark: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.played.drive(outputPlayed)
        )

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputPlayed.events, [
            .next(150, .failure(TestError.someError)),
            .next(160, .failure(TestError.someError)),
            .next(200, .success(true))
        ])
    }

    func testRemoveBookmark() {
        // Arrange
        let inputBookmarks = scheduler.createHotObservable([
            .next(150, FormattedWord("error")),
            .next(160, FormattedWord("rx_error")),
            .next(200, FormattedWord("test"))
        ]).asDriver(onErrorJustReturn: FormattedWord(""))
        let outputBookmarks = scheduler.createObserver(StorageServiceResult.self)
        let viewModel = WordsViewModel(searchWord: MockFactory.createUseCaseStub(),
                                       addBookmark: MockFactory.createUseCaseStub(),
                                       playSound: MockFactory.createUseCaseStub(),
                                       removeBookmark: createMockBookmarkUseCase())
        let input = WordsViewModel.Input(search: Driver.never(),
                                         playUrl: Driver.never(),
                                         addBookmark: Driver.never(),
                                         removeBookmark: inputBookmarks)
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.bookmarked.drive(outputBookmarks)
        )

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputBookmarks.events, [
            .next(150, .failure(TestError.someError)),
            .next(160, .failure(TestError.someError)),
            .next(200, .success(true))
        ])
    }

    private func createMockSearchWordUseCase() -> MockAnyUseCase<SearchWordUseCase.Input, FoundWordResult> {
        return MockFactory.createMockUseCase { value in
            value.word == "error" ? TestError.someError : nil
        } onRxError: { value in
            value.word == "rx_error" ? .failure(TestError.someError) : nil
        } onSuccess: { value in
            .success([FoundWord(value.word)])
        }
    }

    private func createMockBookmarkUseCase() -> MockAnyUseCase<FormattedWord, StorageServiceResult> {
        return MockFactory.createMockUseCase { value in
            value.header == "error" ? TestError.someError : nil
        } onRxError: { value in
            value.header == "rx_error" ? .failure(TestError.someError) : nil
        } onSuccess: { _ in
            .success(true)
        }
    }

    private func createMockPlaySoundUseCase() -> MockAnyUseCase<String, PlayerManagerResult> {
        return MockFactory.createMockUseCase { value in
            value == "error" ? TestError.someError : nil
        } onRxError: { value in
            value == "rx_error" ? .failure(TestError.someError) : nil
        } onSuccess: { _ in
            .success(true)
        }
    }
}
