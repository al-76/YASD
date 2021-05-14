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

    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    func testSearch() {
        // Arrange
        let testString = "test"
        let viewModel = BookmarksViewModel(searchBookmark: createMockSearchBookmark(),
                                           restoreBookmark: createUseCaseStub(),
                                           removeBookmark: createUseCaseStub(),
                                           changedBookmark: createMockChangedBookmarkNever(),
                                           playSound: createUseCaseStub())
        let inputWords = scheduler.createHotObservable([
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
            .next(200, .success([FormattedWord(testString)]))
        ])
    }

    func testRestore() {
        // Arrange
        let testString = "test"
        let inputRestore = scheduler.createHotObservable([
            .next(200, testString),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let outputRestore = scheduler.createObserver(String.self)
        let outputBookmarks = scheduler.createObserver(Bookmarks.self)
        let viewModel = BookmarksViewModel(searchBookmark: createMockSearchBookmark(),
                                           restoreBookmark: createMockRestoreBookmark(),
                                           removeBookmark: createUseCaseStub(),
                                           changedBookmark: createMockChangedBookmarkNever(),
                                           playSound: createUseCaseStub())
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
            .next(200, testString),
            .completed(400)
        ])
        XCTAssertEqual(outputBookmarks.events, [
            .next(200, .success([FormattedWord(testString)]))
        ])
    }
    
    func testChange() {
        // Arrange
        let testData = [FormattedWord("test")]
        let outputBookmarks = scheduler.createObserver(Bookmarks.self)
        let viewModel = BookmarksViewModel(searchBookmark: createMockSearchBookmark(),
                                           restoreBookmark: createMockRestoreBookmark(),
                                           removeBookmark: createUseCaseStub(),
                                           changedBookmark: createMockChangedBookmark(testData),
                                           playSound: createUseCaseStub())
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
        
    private func createMockSearchBookmark() -> MockAnyUseCase<String, Bookmarks> {
        let mockSearchBookmark = MockAnyUseCase(wrapped: MockUseCase<String, Bookmarks>())
        stub(mockSearchBookmark) { stub in
            when(stub.execute(with: anyString())).then { data in
                return Observable.just(.success([FormattedWord(data)]))
            }
        }
        return mockSearchBookmark
    }
    
    private func createMockChangedBookmarkNever() -> MockAnyUseCase<Void, Bookmarks> {
        let mockChangedBookmark = MockAnyUseCase(wrapped: MockUseCase<Void, Bookmarks>())
        stub(mockChangedBookmark) { stub in
            when(stub.execute(with: any())).then { data in
                return Observable.never()
            }
        }
        return mockChangedBookmark
    }
    
    private func createMockChangedBookmark(_ bookmarks: [FormattedWord]) -> MockAnyUseCase<Void, Bookmarks> {
        let mockChangedBookmark = MockAnyUseCase(wrapped: MockUseCase<Void, Bookmarks>())
        stub(mockChangedBookmark) { stub in
            when(stub.execute(with: any())).then { data in
                return Observable.just(.success(bookmarks))
            }
        }
        return mockChangedBookmark
    }
    
    private func createMockRestoreBookmark() -> MockAnyUseCase<String, String> {
        let mockRestoreBookmark = MockAnyUseCase(wrapped: MockUseCase<String, String>())
        stub(mockRestoreBookmark) { stub in
            when(stub.execute(with: any())).then { data in
                return Observable.just(data)
            }
        }
        return mockRestoreBookmark
    }
    
    private func createUseCaseStub<Input, Output>() -> AnyUseCaseStub<Input, Output> {
        return AnyUseCaseStub<Input, Output>(wrapped: UseCaseStub())
    }
}
