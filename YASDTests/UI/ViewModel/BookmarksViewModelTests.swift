//
//  BookmarksViewModelTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 14.05.2020.
//  Copyright © 2020 yac. All rights reserved.
//

@testable import YASD

import Cuckoo
import RxCocoa
import RxSwift
import RxTest
import XCTest

class BookmarksViewModelTests: XCTestCase {
    enum TestError: Error {
        case someError
    }

    static let errorIndex = 3000

    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    func testSearch() {
        // Arrange
        let testString = "test"
        let viewModel = BookmarksViewModel(searchBookmark: createMockSearchBookmark(),
                                           restoreBookmark: MockFactory.createUseCaseStub(),
                                           removeBookmark: MockFactory.createUseCaseStub(),
                                           changedBookmark: createMockChangedBookmarkNever(),
                                           playSound: MockFactory.createUseCaseStub())
        let inputWords = scheduler.createHotObservable([
            .next(150, "error"),
            .next(200, testString),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let outputBookmarks = scheduler.createObserver(FormattedWordResult.self)
        let input = BookmarksViewModel.Input(search: inputWords,
                                             playUrl: Driver.never(),
                                             removeBookmark: Driver.never(),
                                             restore: Driver.never())
        let output = viewModel.transform(from: input)
        output.bookmarks.drive(outputBookmarks)
            .disposed(by: disposeBag)

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputBookmarks.events, [
            .next(150, .failure(TestError.someError)),
            .next(200, .success([FormattedWord(testString)]))
        ])
    }

    func testRestore() {
        // Arrange
        let testString = "test"
        let inputRestore = scheduler.createHotObservable([
            .next(150, "error"),
            .next(200, testString),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let outputRestore = scheduler.createObserver(String.self)
        let outputBookmarks = scheduler.createObserver(Bookmarks.self)
        let viewModel = BookmarksViewModel(searchBookmark: createMockSearchBookmark(),
                                           restoreBookmark: createMockRestoreBookmark(),
                                           removeBookmark: MockFactory.createUseCaseStub(),
                                           changedBookmark: createMockChangedBookmarkNever(),
                                           playSound: MockFactory.createUseCaseStub())
        let input = BookmarksViewModel.Input(search: Driver.never(),
                                             playUrl: Driver.never(),
                                             removeBookmark: Driver.never(),
                                             restore: inputRestore)
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.restored.drive(outputRestore),
            output.bookmarks.drive(outputBookmarks)
        )

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputRestore.events, [
            .next(150, ""),
            .next(200, testString),
            .completed(400)
        ])
        XCTAssertEqual(outputBookmarks.events, [
            .next(150, .success([FormattedWord()])),
            .next(200, .success([FormattedWord(testString)]))
        ])
    }

    func testChange() {
        // Arrange
        let testData = [FormattedWord("test")]
        let outputBookmarks = scheduler.createObserver(Bookmarks.self)
        let viewModel = BookmarksViewModel(searchBookmark: MockFactory.createUseCaseStub(),
                                           restoreBookmark: createMockRestoreBookmark(),
                                           removeBookmark: MockFactory.createUseCaseStub(),
                                           changedBookmark: createMockChangedBookmark(testData),
                                           playSound: MockFactory.createUseCaseStub())
        let input = BookmarksViewModel.Input(search: Driver.never(),
                                             playUrl: Driver.never(),
                                             removeBookmark: Driver.never(),
                                             restore: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.bookmarks.drive(outputBookmarks)
        )

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputBookmarks.events, [
            .next(0, .success(testData))
        ])
    }

    func testRemove() {
        // Arrange
        let testData = [FormattedWord("test")]
        let inputRemove = scheduler.createHotObservable([
            .next(100, -1),
            .next(150, BookmarksViewModelTests.errorIndex),
            .next(200, 20),
            .completed(400)
        ]).asDriver(onErrorJustReturn: -1)
        let outputBookmarks = scheduler.createObserver(Bookmarks.self)
        let viewModel = BookmarksViewModel(searchBookmark: MockFactory.createUseCaseStub(),
                                           restoreBookmark: createMockRestoreBookmark(),
                                           removeBookmark: createRemoveBookmarkUseCaseMock(),
                                           changedBookmark: createMockChangedBookmark(testData),
                                           playSound: MockFactory.createUseCaseStub())
        let input = BookmarksViewModel.Input(search: Driver.never(),
                                             playUrl: Driver.never(),
                                             removeBookmark: inputRemove,
                                             restore: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.bookmarks.drive(outputBookmarks)
        )

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputBookmarks.events, [
            .next(0, .success(testData)),
            .next(150, .success(testData)),
            .next(200, .success(testData))
        ])
    }

    func testPlay() {
        // Arrange
        let inputPlay = scheduler.createHotObservable([
            .next(150, "error"),
            .next(200, "test"),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let outputPlayed = scheduler.createObserver(PlayerManagerResult.self)
        let viewModel = BookmarksViewModel(searchBookmark: MockFactory.createUseCaseStub(),
                                           restoreBookmark: createMockRestoreBookmark(),
                                           removeBookmark: MockFactory.createUseCaseStub(),
                                           changedBookmark: createMockChangedBookmarkNever(),
                                           playSound: createPlaySoundUseCaseMock())
        let input = BookmarksViewModel.Input(search: Driver.never(),
                                             playUrl: inputPlay,
                                             removeBookmark: Driver.never(),
                                             restore: Driver.never())
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.played.drive(outputPlayed)
        )

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputPlayed.events, [
            .next(150, .failure(TestError.someError)),
            .next(200, .success(true)),
            .completed(400)
        ])
    }

    private func createMockSearchBookmark() -> MockAnyUseCase<String, Bookmarks> {
        return MockFactory.createMockUseCase { value in
            value == "error" ? TestError.someError : nil
        } onRxError: { _ in
            nil
        } onSuccess: { value in
            .success([FormattedWord(value)])
        }
    }

    private func createMockChangedBookmarkNever() -> MockAnyUseCase<Void, Bookmarks> {
        let mock = MockAnyUseCase(wrapped: MockUseCase<Void, Bookmarks>())
        stub(mock) { stub in
            when(stub.execute(with: any())).then { _ in
                Observable.never()
            }
        }
        return mock
    }

    private func createMockChangedBookmark(_ bookmarks: [FormattedWord]) -> MockAnyUseCase<Void, Bookmarks> {
        return MockFactory.createMockUseCase { _ in
            nil
        } onRxError: { _ in
            nil
        } onSuccess: { _ in
            .success(bookmarks)
        }
    }

    private func createMockRestoreBookmark() -> MockAnyUseCase<String, String> {
        return MockFactory.createMockUseCase { value in
            value == "error" ? TestError.someError : nil
        } onRxError: { _ in
            nil
        } onSuccess: { value in
            value
        }
    }

    private func createRemoveBookmarkUseCaseMock() -> MockAnyUseCase<Int, StorageServiceResult> {
        return MockFactory.createMockUseCase { value in
            value == BookmarksViewModelTests.errorIndex ? TestError.someError : nil
        } onRxError: { _ in
            nil
        } onSuccess: { _ in
            .success(true)
        }
    }

    private func createPlaySoundUseCaseMock() -> MockAnyUseCase<String, PlayerManagerResult> {
        return MockFactory.createMockUseCase { value in
            value == "error" ? TestError.someError : nil
        } onRxError: { _ in
            nil
        } onSuccess: { _ in
            .success(true)
        }
    }
}
