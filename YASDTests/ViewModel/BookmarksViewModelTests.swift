//
//  BookmarksViewModelTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 14.05.2020.
//  Copyright © 2020 yac. All rights reserved.
//

@testable import YASD

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Cuckoo

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
        let output = viewModel.transform(from: BookmarksViewModel
                                            .Input(search: inputWords,
                                                   playUrl: Driver.never(),
                                                   removeBookmark: Driver.never(),
                                                   restore: Driver.never()))
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
        let output = viewModel.transform(from: BookmarksViewModel
                                            .Input(search: Driver.never(),
                                                   playUrl: Driver.never(),
                                                   removeBookmark: Driver.never(),
                                                   restore: inputRestore))
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
        let output = viewModel.transform(from: BookmarksViewModel
                                            .Input(search: Driver.never(),
                                                   playUrl: Driver.never(),
                                                   removeBookmark: Driver.never(),
                                                   restore: Driver.never()))
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
        let output = viewModel.transform(from: BookmarksViewModel
                                            .Input(search: Driver.never(),
                                                   playUrl: Driver.never(),
                                                   removeBookmark: inputRemove,
                                                   restore: Driver.never()))
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
        let output = viewModel.transform(from: BookmarksViewModel
                                            .Input(search: Driver.never(),
                                                   playUrl: inputPlay,
                                                   removeBookmark: Driver.never(),
                                                   restore: Driver.never()))
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
        let mockSearchBookmark = MockAnyUseCase(wrapped: MockUseCase<String, Bookmarks>())
        stub(mockSearchBookmark) { stub in
            when(stub.execute(with: anyString())).then { data in
                if (data == "error") {
                    return Observable.error(TestError.someError)
                }
                return Observable.just(.success([FormattedWord(data)]))
            }
        }
        return mockSearchBookmark
    }
    
    private func createMockChangedBookmarkNever() -> MockAnyUseCase<Void, Bookmarks> {
        let mockChangedBookmark = MockAnyUseCase(wrapped: MockUseCase<Void, Bookmarks>())
        stub(mockChangedBookmark) { stub in
            when(stub.execute(with: any())).then { _ in
                return Observable.never()
            }
        }
        return mockChangedBookmark
    }
    
    private func createMockChangedBookmark(_ bookmarks: [FormattedWord]) -> MockAnyUseCase<Void, Bookmarks> {
        let mockChangedBookmark = MockAnyUseCase(wrapped: MockUseCase<Void, Bookmarks>())
        stub(mockChangedBookmark) { stub in
            when(stub.execute(with: any())).then { _ in
                return Observable.just(.success(bookmarks))
            }
        }
        return mockChangedBookmark
    }
    
    private func createMockRestoreBookmark() -> MockAnyUseCase<String, String> {
        let mockRestoreBookmark = MockAnyUseCase(wrapped: MockUseCase<String, String>())
        stub(mockRestoreBookmark) { stub in
            when(stub.execute(with: any())).then { data in
                if (data == "error") {
                    return Observable.error(TestError.someError)
                }
                return Observable.just(data)
            }
        }
        return mockRestoreBookmark
    }

    private func createRemoveBookmarkUseCaseMock() -> MockAnyUseCase<Int, StorageServiceResult> {
        let mockRemoveBookmark = MockAnyUseCase(wrapped: MockUseCase<Int, StorageServiceResult>())
        stub(mockRemoveBookmark) { stub in
            when(stub.execute(with: any())).then { index in
                if (index == BookmarksViewModelTests.errorIndex) {
                    return Observable.error(TestError.someError)
                }
                return Observable.just(.success(true))
            }
        }
        return mockRemoveBookmark
    }
    
    private func createPlaySoundUseCaseMock() -> MockAnyUseCase<String, PlayerManagerResult> {
        let mockPlaySound = MockAnyUseCase(wrapped: MockUseCase<String, PlayerManagerResult>())
        stub(mockPlaySound) { stub in
            when(stub.execute(with: any())).then { url in
                if (url == "error") {
                    return Observable.error(TestError.someError)
                }
                return Observable.just(.success(true))
            }
        }
        return mockPlaySound
    }
}
