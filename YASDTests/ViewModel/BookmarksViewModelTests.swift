////
////  BookmarksViewModelTests.swift
////  YASDTests
////
////  Created by Vyacheslav Konopkin on 14.05.2020.
////  Copyright © 2020 yac. All rights reserved.
////
//
//@testable import YASD
//
//import XCTest
//import RxSwift
//import RxCocoa
//import RxTest
//import Cuckoo
//
//class BookmarksViewModelTests: XCTestCase {
//    enum TestError: Error {
//        case someError
//    }
//
//    let disposeBag = DisposeBag()
//    let scheduler = TestScheduler(initialClock: 0)
//
//    // Inputs
//    let errorUrl = "error"
//    lazy var inputWords = scheduler.createHotObservable([
//        .next(200, "test2"),
//        .next(250, "test3"),
//        .next(300, "test"),
//        .completed(400)
//    ]).asDriver(onErrorJustReturn: "")
//    lazy var inputRestore = scheduler.createHotObservable([
//        .next(200, "test2"),
//        .next(250, "test3"),
//        .next(300, "test"),
//        .completed(400)
//    ]).asDriver(onErrorJustReturn: "")
//    lazy var inputUrls = scheduler.createHotObservable([
//        .next(150, "some_url"),
//        .next(200, "some_url_2"),
//        .next(300, errorUrl),
//        .completed(400)
//    ]).asDriver(onErrorJustReturn: "")
//    lazy var inputBookmarks = scheduler.createHotObservable([
//        .next(150, 0),
//        .next(200, 0),
//        .completed(400)
//    ]).asDriver(onErrorJustReturn: -1)
//
//    // Outputs
//    lazy var bookmarks = scheduler.createObserver(FormattedWordResult.self)
//    lazy var played = scheduler.createObserver(PlayerManagerResult.self)
//
//    func testSearch() {
//        // Arrange
//        let data = createBookmarksMock([FormattedWord("test2"), FormattedWord("test3")])
//        let viewModel = BookmarksViewModel(bookmarks: data,
//                                           player: PlayerManagerStub(),
//                                           spotlight: ExternalCacheServiceStub())
//        let output = viewModel.transform(from: BookmarksViewModel.Input(search: inputWords,
//                                                                        playUrl: Driver.never(),
//                                                                        removeBookmark: Driver.never(),
//                                                                        restore: Driver.never()))
//        output.bookmarks.drive(bookmarks)
//            .disposed(by: disposeBag)
//
//        // Act
//        scheduler.start()
//
//        // Assert
//        XCTAssertEqual(bookmarks.events, [
//            .next(200, .success([FormattedWord("test2")])),
//            .next(250, .success([FormattedWord("test3")])),
//            .next(300, .success([FormattedWord("test2"), FormattedWord("test3")]))
//        ])
//    }
//
//    func testRestore() {
//        // Arrange
//        let data = createBookmarksMock([FormattedWord("test2"), FormattedWord("test3")])
//        let viewModel = BookmarksViewModel(bookmarks: data,
//                                           player: PlayerManagerStub(),
//                                           spotlight: createSpotlightMock())
//        let output = viewModel.transform(from: BookmarksViewModel.Input(search: Driver.never(),
//                                                                        playUrl: Driver.never(),
//                                                                        removeBookmark: Driver.never(),
//                                                                        restore: inputRestore))
//        output.bookmarks.drive(bookmarks)
//            .disposed(by: disposeBag)
//
//        // Act
//        scheduler.start()
//
//        // Assert
//        XCTAssertEqual(bookmarks.events, [
//            .next(200, .success([FormattedWord("test2")])),
//            .next(250, .success([FormattedWord("test3")])),
//            .next(300, .success([FormattedWord("test2"), FormattedWord("test3")]))
//        ])
//    }
//
//    func testPlay() {
//        // Arrange
//        let error = TestError.someError
//        let viewModel = BookmarksViewModel(bookmarks: createBookmarksMock([]),
//                                           player: MockFactory.createMockPlayerManager(errorUrl: errorUrl, error: error),
//                                           spotlight: ExternalCacheServiceStub())
//        let output = viewModel.transform(from: BookmarksViewModel.Input(search: Driver.never(),
//                                                                        playUrl: inputUrls,
//                                                                        removeBookmark: Driver.never(),
//                                                                        restore: Driver.never()))
//        output.played.drive(played)
//            .disposed(by: disposeBag)
//
//        // Act
//        scheduler.start()
//
//        // Assert
//        XCTAssertEqual(played.events, [
//            .next(150, .success(true)),
//            .next(200, .success(true)),
//            .next(300, .failure(error)),
//            .completed(400)
//        ])
//    }
//
//    func testRemoveBookmarks() {
//        // Arrange
//        let data = createBookmarksMock([FormattedWord("test2"), FormattedWord("test3")])
//        let viewModel = BookmarksViewModel(bookmarks: data,
//                                           player: PlayerManagerStub(),
//                                           spotlight: createSpotlightMock())
//        let output = viewModel.transform(from: BookmarksViewModel.Input(search: Driver.never(),
//                                                                        playUrl: Driver.never(),
//                                                                        removeBookmark: inputBookmarks,
//                                                                        restore: Driver.never()))
//        output.bookmarks.drive(bookmarks)
//            .disposed(by: disposeBag)
//
//        // Act
//        scheduler.start()
//
//        // Assert
//        XCTAssertEqual(bookmarks.events, [
//            .next(150, .success([FormattedWord("test3")])),
//            .next(200, .success([]))
//        ])
//    }
//
//    func testErrorNilViewModel() {
//        // Arrange
//        let data = createBookmarksMock([FormattedWord("test2"), FormattedWord("test3")])
//        var viewModel: BookmarksViewModel? = BookmarksViewModel(bookmarks: data,
//                                           player: MockFactory.createMockPlayerManager(),
//                                           spotlight: createSpotlightMock())
//        let output = viewModel!.transform(from: BookmarksViewModel.Input(search: inputWords,
//                                                            playUrl: inputUrls,
//                                                            removeBookmark: inputBookmarks,
//                                                            restore: inputWords))
//        disposeBag.insert(
//            output.bookmarks.drive(bookmarks),
//            output.played.drive(played)
//        )
//
//        // Act
//        viewModel = nil
//        scheduler.start()
//
//        // Assert
//        XCTAssertEqual(bookmarks.events, [
//            .next(150, .success([])),
//            .next(200, .success([])),
//            .next(200, .success([])),
//            .next(250, .success([])),
//            .next(250, .success([])),
//            .next(300, .success([])),
//            .next(300, .success([]))
//        ])
//        XCTAssertEqual(played.events, [
//            .next(150, .success(false)),
//            .next(200, .success(false)),
//            .next(300, .success(false)),
//            .completed(400)
//        ])
//    }
//
//    private func createBookmarksMock(_ data: [FormattedWord]) -> AnyStorageRepository<FormattedWord> {
//        return AnyStorageRepository<FormattedWord>(wrapped: MockFactory.createMockStorageRepository(data: data));
//    }
//
//    private func createSpotlightMock() -> ExternalCacheService {
//        let mock = MockExternalCacheService()
//        stub(mock) { stub in
//            when(stub.getTitle(from: anyString())).then { $0 }
//            when(stub.index(data: any())).thenReturn(Observable.just(.success(())))
//        }
//        return mock
//    }
//}
