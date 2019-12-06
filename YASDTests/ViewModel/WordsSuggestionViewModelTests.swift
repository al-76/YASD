//
//  WordsSuggestionViewModelTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 22.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//
@testable import YASD

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Cuckoo

class WordsSuggestionViewModelTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    let disposeBag = DisposeBag()
    
    func testGetSuggestion() {
        // Arrange
        let errorWord = "error_word"
        let scheduler = TestScheduler(initialClock: 0)
        let inputWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .next(250, "test3"),
            .next(350, errorWord),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let suggestions = scheduler.createObserver(SuggestionResult.self)
        let viewModel = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: errorWord),
                                                 history: TestHistoryService(value: [], whenError: ""))
        viewModel.transform(from: WordsSuggestionViewModel.Input(searchText: inputWords,
                                                                 forHistory: Driver.just("")))
            .suggestions.drive(suggestions).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(suggestions.events, [
            .next(200, SuggestionResult.success(["test2"])),
            .next(250, SuggestionResult.success(["test3"])),
            .next(350, SuggestionResult.failure(TestError.someError)),
            .completed(400)
       ])
    }
    
    func testGetHistory() {
        // Arrange
        let errorWord = "error_word"
        let scheduler = TestScheduler(initialClock: 0)
        let inputWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .next(250, "test3"),
            .next(350, errorWord),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let initialValue = ["test2", "test3_abc", "test3_cde", "some_words"]
        let history = scheduler.createObserver(SuggestionResult.self)
        let viewModel = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: ""),
                                                 history: TestHistoryService(value: initialValue, whenError: errorWord))
        viewModel.transform(from: WordsSuggestionViewModel.Input(searchText: inputWords,
                                                                 forHistory: Driver.just("")))
            .history.drive(history).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(history.events, [
            .next(0, SuggestionResult.success(initialValue)),
            .next(200, SuggestionResult.success(["test2"])),
            .next(250, SuggestionResult.success(["test3_abc", "test3_cde"])),
            .next(350, SuggestionResult.failure(TestError.someError)),
            .completed(400)
        ])
    }
    
    func testSaveHistory() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let historyWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .next(250, "test3"),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let history = scheduler.createObserver(SuggestionResult.self)
        let viewModel = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: ""),
                                                 history: TestHistoryService(value: [], whenError: "error_word"))
        viewModel.transform(from: WordsSuggestionViewModel.Input(searchText: Driver.just(""),
                                                                 forHistory: historyWords))
            .history.drive(history).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(history.events, [
            .next(200, SuggestionResult.success(["test2"])),
            .next(250, SuggestionResult.success(["test3"])),
            .completed(400)
        ])
    }
    
    func testSuggestionErrorNilViewModel() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let inputWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .next(250, "test3"),
            .completed(400)
       ])
        let suggestions = scheduler.createObserver(SuggestionResult.self)
        let history = scheduler.createObserver(SuggestionResult.self)
        var viewModel: WordsSuggestionViewModel? = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: "error_word"),
                                                                            history: TestHistoryService(value: [], whenError: ""))
        let transform = viewModel?.transform(from: WordsSuggestionViewModel.Input(searchText: inputWords.asDriver(onErrorJustReturn: ""),
                                                                                  forHistory: inputWords.asDriver(onErrorJustReturn: "")))
        transform?.suggestions.drive(suggestions).disposed(by: disposeBag)
        transform?.history.drive(history).disposed(by: disposeBag)

        // Act
        viewModel = nil
        scheduler.start()

        // Assert
        XCTAssertEqual(suggestions.events, [
            .next(200, SuggestionResult.success([])),
            .next(250, SuggestionResult.success([])),
            .completed(400)
        ])
        XCTAssertEqual(history.events, [.completed(400)])
    }
    
    func createMockLexinService(whenError errorWord: String) -> MockLexinService {
        let stubParameters = createParametersStorageStub()
        let mockNetwork = MockNetworkService(cache: MockCacheService(cache: MockDataCache(name: "Test")),
                                                     network: MockNetwork())
        let mockApi = MockLexinApi(network: mockNetwork,
                                   parserWords: MockLexinParserWords(),
                                   parserSuggestions: MockLexinParserSuggestion())
        let mockProvider = MockLexinApiProvider(defaultApi: mockApi, folketsApi: mockApi, swedishApi: mockApi)
        let mock = MockLexinService(parameters: stubParameters, provider: mockProvider)
        stub(mock) { stub in
            when(stub.language()).thenReturn(stubParameters.language)
            when(stub.suggestion(any())).then { word in
                return Observable<SuggestionResult>.create { observable in
                    if word == errorWord {
                        observable.on(.error(TestError.someError))
                    } else {
                        observable.on(.next(.success([word])))
                    }
                    observable.onCompleted()
                    return Disposables.create {}
                }
            }
        }
        return mock
    }
    
    private func createParametersStorageStub() -> ParametersStorageStub {
        let language = Language(name: "test", code: "test")
        DefaultValueRegistry.register(value: language, forType: Language.self)
        let stub = ParametersStorageStub(storage: StorageStub(),
                                              language: language)
        return stub
    }
    
    class TestHistoryService : HistoryService {
        private var data = [String]()
        private let errorWord: String
        
        init(value: [String], whenError errorWord: String) {
            self.data = value
            self.errorWord = errorWord
            super.init()
        }
        
        override func get(with word: String) -> Observable<SuggestionResult> {
            return Observable.create { [weak self] observer in
                if word == self?.errorWord {
                    observer.onError(TestError.someError)
                } else if let data = self?.data {
                    observer.onNext(SuggestionResult.success(data.filter { $0.starts(with: word) }))
                } else {
                    observer.onNext(SuggestionResult.success([]))
                }
                observer.onCompleted()

                return Disposables.create {}
            }
        }
        
        override func add(_ word: String) -> Observable<Void> {
            return Observable.create { [weak self] observer in
                if !word.isEmpty {
                    self?.data.append(word)//insert(word)
                }
                
                observer.onNext(Void())
                observer.onCompleted()
                
                return Disposables.create {}
            }
        }
        
        override func remove(_ word: String) -> Observable<Void> {
            return Observable.create { [weak self] observer in
                if var data = self?.data, let index = data.firstIndex(of: word) {
                    data.remove(at: index)
                }
                
                observer.onNext(Void())
                observer.onCompleted()
                
                return Disposables.create {}
            }
        }
    }
}
