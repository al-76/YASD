////
////  WordsTableViewModelTests.swift
////  YASDTests
////
////  Created by Vyacheslav Konopkin on 16/05/2019.
////  Copyright © 2019 yac. All rights reserved.
////
//@testable import YASD
//
//import XCTest
//import RxSwift
//import RxCocoa
//import RxTest
//import Cuckoo
//
//class WordsViewModelTests: XCTestCase {
//    enum TestError: Error {
//        case someError
//    }
//    
//    let disposeBag = DisposeBag()
//    
//    func testSearch() {
//        // Arrange
//        let errorWord = "error_word"
//        let scheduler = TestScheduler(initialClock: 0)
//        let inputWords = scheduler.createHotObservable([
//            .next(200, "test2"),
//            .next(250, "test3"),
//            .next(350, errorWord),
//            .completed(400)
//        ]).asDriver(onErrorJustReturn: "")
//        let foundWords = scheduler.createObserver(FoundWordResult.self)
//        let loading = scheduler.createObserver(Bool.self)
//        let viewModel = WordsViewModel(words: createMockWordsService(whenError: errorWord),
//                                       player: MockFactory.createMockPlayerManager(),
//                                       bookmarks: createBookmarksStub())
//        let output = viewModel.transform(from: WordsViewModel.Input(search: inputWords,
//                                                       playUrl: Driver.never(),
//                                                       addBookmark: Driver.never(),
//                                                       removeBookmark: Driver.never()))
//        disposeBag.insert(
//            output.foundWords.drive(foundWords),
//            output.loading.drive(loading)
//        )
//        
//        // Act
//        scheduler.start()
//                
//        // Assert
//        XCTAssertEqual(foundWords.events, [
//            .next(200, FoundWordResult.success([FoundWord("test2")])),
//            .next(250, FoundWordResult.success([FoundWord("test3")])),
//            .next(350, FoundWordResult.failure(TestError.someError))
//        ])
//        XCTAssertEqual(loading.events, [
//            .next(0, false),
//            .next(200, true),
//            .next(200, false),
//            .next(250, true),
//            .next(250, false),
//            .next(350, true),
//            .next(350, false),
//        ])
//    }
//    
//    func testSearchErrorNilViewModel() {
//        // Arrange
//        let scheduler = TestScheduler(initialClock: 0)
//        let inputWords = scheduler.createHotObservable([
//            .next(200, "test2"),
//            .next(250, "test3"),
//            .completed(400)
//        ]).asDriver(onErrorJustReturn: "")
//        let foundWords = scheduler.createObserver(FoundWordResult.self)
//        var viewModel: WordsViewModel?  = WordsViewModel(words: createMockWordsService(whenError: "error_word"),
//                                                         player: MockFactory.createMockPlayerManager(),
//                                                         bookmarks: StorageServiceStub<FormattedWord>(id: "test", storage: StorageStub()))
//        viewModel?.transform(from: WordsViewModel.Input(search: inputWords,
//                                                        playUrl: Driver.never(),
//                                                        addBookmark: Driver.never(),
//                                                        removeBookmark: Driver.never()))
//            .foundWords.drive(foundWords).disposed(by: disposeBag)
//        
//        // Act
//        viewModel = nil
//        scheduler.start()
//        
//        // Assert
//        XCTAssertEqual(foundWords.events, [
//            .next(200, FoundWordResult.success([])),
//            .next(250, FoundWordResult.success([]))
//        ])
//    }
//    
//    func testSearchUpdateOnSwitchParameters() {
//        // Arrange
//        let errorWord = "error_word"
//        let scheduler = TestScheduler(initialClock: 0)
//        let inputWords = scheduler.createHotObservable([
//            .next(200, "test2"),
//            .completed(400)
//        ]).asDriver(onErrorJustReturn: "")
//        let foundWords = scheduler.createObserver(FoundWordResult.self)
//        let words = createMockWordsService(whenError: errorWord)
//        let viewModel = WordsViewModel(words: words,
//                                       player: MockFactory.createMockPlayerManager(),
//                                       bookmarks: createBookmarksStub())
//        viewModel.transform(from: WordsViewModel.Input(search: inputWords,
//                                                       playUrl: Driver.never(),
//                                                       addBookmark: Driver.never(),
//                                                       removeBookmark: Driver.never()))
//            .foundWords.drive(foundWords).disposed(by: disposeBag)
//        
//        // Act
//        scheduler.start()
//        words.language()
//            .onNext(Language(name: "test2", code: "test2_code"))
//        
//        // Assert
//        XCTAssertEqual(foundWords.events, [
//            .next(200, FoundWordResult.success([FoundWord("test2")])),
//            .next(400, FoundWordResult.success([FoundWord("test2")]))
//        ])
//    }
//    
//    func testPlay() {
//        // Arrange
//        let error = TestError.someError
//        let errorUrl = "error"
//        let scheduler = TestScheduler(initialClock: 0)
//        let inputUrls = scheduler.createHotObservable([
//            .next(150, "some_url"),
//            .next(200, "some_url_2"),
//            .next(300, errorUrl),
//            .completed(400)
//        ]).asDriver(onErrorJustReturn: "")
//        let played = scheduler.createObserver(PlayerManagerResult.self)
//        let viewModel = WordsViewModel(words: createMockWordsService(whenError: ""),
//                                       player: MockFactory.createMockPlayerManager(errorUrl: errorUrl, error: error),
//                                       bookmarks: StorageServiceStub<FormattedWord>(id: "test", storage: StorageStub()))
//        viewModel.transform(from: WordsViewModel.Input(search: Driver.never(),
//                                                       playUrl: inputUrls,
//                                                       addBookmark: Driver.never(),
//                                                       removeBookmark: Driver.never()))
//            .played.drive(played)
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
//    func testAddBookmarks() {
//        // Arrange
//        let scheduler = TestScheduler(initialClock: 0)
//        let inputBookmarks = scheduler.createHotObservable([
//            .next(150, FormattedWord()),
//            .next(200, FormattedWord()),
//            .completed(400)
//        ]).asDriver(onErrorJustReturn: FormattedWord())
//        let bookmarked = scheduler.createObserver(StorageServiceResult.self)
//        let viewModel = WordsViewModel(words: createMockWordsService(whenError: ""),
//                                       player: MockFactory.createMockPlayerManager(),
//                                       bookmarks: createBookmarksStub())
//        viewModel.transform(from: WordsViewModel.Input(search: Driver.never(),
//                                                       playUrl: Driver.never(),
//                                                       addBookmark: inputBookmarks,
//                                                       removeBookmark: Driver.never()))
//            .bookmarked.drive(bookmarked)
//            .disposed(by: disposeBag)
//        
//        // Act
//        scheduler.start()
//        
//        // Assert
//        XCTAssertEqual(bookmarked.events, [
//            .next(150, .success(true)),
//            .next(200, .success(true))
//        ])
//    }
//    
//    func testRemoveBookmarks() {
//        // Arrange
//        let scheduler = TestScheduler(initialClock: 0)
//        let inputBookmarks = scheduler.createHotObservable([
//            .next(150, FormattedWord()),
//            .next(200, FormattedWord()),
//            .completed(400)
//        ]).asDriver(onErrorJustReturn: FormattedWord())
//        let bookmarked = scheduler.createObserver(StorageServiceResult.self)
//        let viewModel = WordsViewModel(words: createMockWordsService(whenError: ""),
//                                       player: MockFactory.createMockPlayerManager(),
//                                       bookmarks: createBookmarksStub())
//        viewModel.transform(from: WordsViewModel.Input(search: Driver.never(),
//                                                       playUrl: Driver.never(),
//                                                       addBookmark: Driver.never(),
//                                                       removeBookmark: inputBookmarks))
//            .bookmarked.drive(bookmarked)
//            .disposed(by: disposeBag)
//        
//        // Act
//        scheduler.start()
//        
//        // Assert
//        XCTAssertEqual(bookmarked.events, [
//            .next(150, .success(true)),
//            .next(200, .success(true))
//        ])
//    }
//    
//    private func createMockWordsService(whenError errorWord: String) -> MockWordsService {
//        let stubParameters = createParametersStorageStub()
//        let stubLexin = LexinServiceStub()
//        let mock = MockWordsService(lexin: stubLexin,
//                                    formatter: LexinServiceFormatterStub(),
//                                    bookmarks: createBookmarksStub())
//        stub(mock) { stub in
//            when(stub.language()).thenReturn(stubParameters.language)
//            when(stub.search(any())).then { word in
//                return Observable<FoundWordResult>.create { observable in
//                    if word == errorWord {
//                        observable.on(.error(TestError.someError))
//                    } else if !word.isEmpty { // ignore initial search on loaded parameters
//                        observable.on(.next(.success([FoundWord(word)])))
//                    }
//                    observable.onCompleted()
//                    return Disposables.create {}
//                }
//            }
//        }
//        return mock
//    }
//    
//    private func createParametersStorageStub() -> ParametersStorageStub {
//        let language = Language(name: "test", code: "test")
//        DefaultValueRegistry.register(value: language, forType: Language.self)
//        let stub = ParametersStorageStub(storage: StorageStub(),
//                                         language: language)
//        return stub
//    }
//    
//    private func createBookmarksStub() -> StorageServiceStub<FormattedWord> {
//        DefaultValueRegistry.register(value: Observable.just(.success(true)), forType:  Observable<StorageServiceResult>.self)
//        return StorageServiceStub<FormattedWord>(id: "bookmarks", storage: StorageStub())
//    }
//}
