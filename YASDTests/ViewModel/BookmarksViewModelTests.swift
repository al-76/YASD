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

    func testSearch() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let inputWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .next(250, "test3"),
            .next(300, "test"),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let bookmarks = scheduler.createObserver(FormattedWordResult.self)
        let data = createBookmarksMock([FormattedWord("test2"), FormattedWord("test3")])
        let viewModel = BookmarksViewModel(bookmarks: data,
                                           player: MockFactory.createMockPlayerService(),
                                           spotlight: MockSpotlight())
        let output = viewModel.transform(from: BookmarksViewModel.Input(search: inputWords,
                                                                        playUrl: Driver.never(),
                                                                        removeBookmark: Driver.never(),
                                                                        restore: Driver.never()))
        output.bookmarks.drive(bookmarks)
            .disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(bookmarks.events, [
            .next(200, .success([FormattedWord("test2")])),
            .next(250, .success([FormattedWord("test3")])),
            .next(300, .success([FormattedWord("test2"), FormattedWord("test3")]))
        ])
    }
    
    func testRestore() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let inputRestore = scheduler.createHotObservable([
            .next(200, "test2"),
            .next(250, "test3"),
            .next(300, "test"),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let bookmarks = scheduler.createObserver(FormattedWordResult.self)
        let data = createBookmarksMock([FormattedWord("test2"), FormattedWord("test3")])
        let viewModel = BookmarksViewModel(bookmarks: data,
                                           player: MockFactory.createMockPlayerService(),
                                           spotlight: createSpotlightMock())
        let output = viewModel.transform(from: BookmarksViewModel.Input(search: Driver.never(),
                                                                        playUrl: Driver.never(),
                                                                        removeBookmark: Driver.never(),
                                                                        restore: inputRestore))
        output.bookmarks.drive(bookmarks)
            .disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(bookmarks.events, [
            .next(200, .success([FormattedWord("test2")])),
            .next(250, .success([FormattedWord("test3")])),
            .next(300, .success([FormattedWord("test2"), FormattedWord("test3")]))
        ])
    }
    
    func testPlay() {
        // Arrange
        let error = TestError.someError
        let errorUrl = "error"
        let scheduler = TestScheduler(initialClock: 0)
        let inputUrls = scheduler.createHotObservable([
            .next(150, "some_url"),
            .next(200, "some_url_2"),
            .next(300, errorUrl),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let played = scheduler.createObserver(PlayerServiceResult.self)
        let viewModel = BookmarksViewModel(bookmarks: createBookmarksMock([]),
                                           player: MockFactory.createMockPlayerService(errorUrl: errorUrl, error: error),
                                           spotlight: MockSpotlight())
        let output = viewModel.transform(from: BookmarksViewModel.Input(search: Driver.never(),
                                                                        playUrl: inputUrls,
                                                                        removeBookmark: Driver.never(),
                                                                        restore: Driver.never()))
        output.played.drive(played)
            .disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(played.events, [
            .next(150, .success(true)),
            .next(200, .success(true)),
            .next(300, .failure(error)),
            .completed(400)
        ])
    }
    
    func testRemoveBookmarks() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let inputBookmarks = scheduler.createHotObservable([
            .next(150, 0),
            .next(200, 0),
            .completed(400)
        ]).asDriver(onErrorJustReturn: -1)
        let bookmarks = scheduler.createObserver(FormattedWordResult.self)
        let data = createBookmarksMock([FormattedWord("test2"), FormattedWord("test3")])
        let viewModel = BookmarksViewModel(bookmarks: data,
                                           player: MockFactory.createMockPlayerService(),
                                           spotlight: createSpotlightMock())
        let output = viewModel.transform(from: BookmarksViewModel.Input(search: Driver.never(),
                                                                        playUrl: Driver.never(),
                                                                        removeBookmark: inputBookmarks,
                                                                        restore: Driver.never()))
        output.bookmarks.drive(bookmarks)
            .disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(bookmarks.events, [
            .next(150, .success([FormattedWord("test3")])),
            .next(200, .success([]))
        ])
    }
    
    func testErrorNilViewModel() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let inputWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .next(250, "test3"),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let inputBookmarks = scheduler.createHotObservable([
            .next(150, 0),
            .next(300, 0),
            .completed(500)
        ]).asDriver(onErrorJustReturn: -1)
        let inputUrls = scheduler.createHotObservable([
            .next(150, "some_url"),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let bookmarks = scheduler.createObserver(FormattedWordResult.self)
        let played = scheduler.createObserver(PlayerServiceResult.self)
        let data = createBookmarksMock([FormattedWord("test2"), FormattedWord("test3")])
        var viewModel: BookmarksViewModel? = BookmarksViewModel(bookmarks: data,
                                           player: MockFactory.createMockPlayerService(),
                                           spotlight: MockSpotlight())
        let output = viewModel!.transform(from: BookmarksViewModel.Input(search: inputWords,
                                                            playUrl: inputUrls,
                                                            removeBookmark: inputBookmarks,
                                                            restore: inputWords))
        disposeBag.insert(
            output.bookmarks.drive(bookmarks),
            output.played.drive(played)
        )
        
        // Act
        viewModel = nil
        scheduler.start()
        
        // Assert
        XCTAssertEqual(bookmarks.events, [
            .next(200, .success([])),
            .next(200, .success([])),
            .next(250, .success([])),
            .next(250, .success([])),
            .completed(500)
        ])
        XCTAssertEqual(played.events, [
            .next(150, .success(false)),
            .completed(400)
        ])
    }
    
    private func createBookmarksMock(_ data: [FormattedWord]) -> StorageService<FormattedWord> {
        return StorageService<FormattedWord>(id: "test", storage: createMockStorage(data: data))
    }
    
    private func createMockStorage(data: [FormattedWord]) -> MockStorage {
        let mock = MockStorage()
        stub(mock) { stub in
            when(stub.get(id: anyString(), defaultObject: any([FormattedWord].self)))
                .then { id, defaultObject -> [FormattedWord] in return data }
            when(stub.save(id: anyString(), object: any([FormattedWord].self))).thenDoNothing()
        }
        return mock
    }
    
    private func createSpotlightMock() -> MockSpotlight {
        let mock = MockSpotlight()
        stub(mock) { stub in
            when(stub.getTitle(from: anyString())).then { $0 }
            when(stub.index(data: any())).thenReturn(Observable.just(.success(())))
        }
        return mock
    }
}
