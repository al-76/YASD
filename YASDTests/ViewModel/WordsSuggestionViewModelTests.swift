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
        let result = scheduler.createObserver(SuggestionItemResult.self)
        let viewModel = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: errorWord),
                                                 history: TestHistoryService(value: [], whenError: ""))
        viewModel.transform(from: WordsSuggestionViewModel.Input(searchText: inputWords,
                                                                 forHistory: Driver.just(""),
                                                                 removeHistory: Driver.just((current: "", removed: ""))))
            .suggestions.drive(result).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(result.events, [
            .next(200, SuggestionItemResult.success(createSuggestionItems(["test2"], false))),
            .next(250, SuggestionItemResult.success(createSuggestionItems(["test3"], false))),
            .next(350, SuggestionItemResult.failure(TestError.someError)),
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
        let result = scheduler.createObserver(SuggestionItemResult.self)
        let viewModel = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: ""),
                                                 history: TestHistoryService(value: initialValue, whenError: errorWord))
        viewModel.transform(from: WordsSuggestionViewModel.Input(searchText: inputWords,
                                                                 forHistory: Driver.just(""),
                                                                 removeHistory: Driver.just(("", ""))))
            .suggestions.drive(result).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(result.events, [
            .next(200, SuggestionItemResult.success(createSuggestionItems(["test2"], true))),
            .next(250, SuggestionItemResult.success([
                SuggestionItem(suggestion: "test3", removable: false),
                SuggestionItem(suggestion: "test3_abc", removable: true),
                SuggestionItem(suggestion: "test3_cde", removable: true)
            ])),
            .next(350, SuggestionItemResult.failure(TestError.someError)),
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
        let result = scheduler.createObserver(SuggestionItemResult.self)
        let viewModel = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: "error_word"),
                                                 history: TestHistoryService(value: [], whenError: "error_word"))
        viewModel.transform(from: WordsSuggestionViewModel.Input(searchText: Driver.just(""),
                                                                 forHistory: historyWords, removeHistory: Driver.just(("", ""))))
            .suggestions.drive(result).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(result.events, [
            .next(0, SuggestionItemResult.success(createSuggestionItems([""], false))),
            .next(200, SuggestionItemResult.success(createSuggestionItems(["test2"], true))),
            .next(250, SuggestionItemResult.success(createSuggestionItems(["test3"], true))),
            .completed(400)
        ])
    }
    
    func testRemoveHistory() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let inputRemovedWords = scheduler.createHotObservable([
            .next(200, (current: "test2", removed: "test3")),
            .completed(400)
        ]).asDriver(onErrorJustReturn: (current: "", removed: ""))
        let result = scheduler.createObserver(SuggestionItemResult.self)
        let viewModel = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: "error_word"),
                                                 history: TestHistoryService(value: ["test2", "test3"], whenError: "error_word"))
        viewModel.transform(from: WordsSuggestionViewModel.Input(searchText: Driver.just(""),
                                                                 forHistory: Driver.just(""),
                                                                 removeHistory: inputRemovedWords))
            .suggestions.drive(result).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(result.events, [
            .next(0, SuggestionItemResult.success([
                SuggestionItem(suggestion: "", removable: false),
                SuggestionItem(suggestion: "test2", removable: true),
                SuggestionItem(suggestion: "test3", removable: true)
            ])),
            .next(200, SuggestionItemResult.success(createSuggestionItems(["test2"], true))),
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
        ]).asDriver(onErrorJustReturn: "")
        let inputRemovedWords = scheduler.createHotObservable([
            .next(300, (current: "test2", removed: "test2")),
            .next(350, (current: "test3", removed: "test3")),
            .completed(500)
        ]).asDriver(onErrorJustReturn: (current: "", removed: ""))
        let result = scheduler.createObserver(SuggestionItemResult.self)
        var viewModel: WordsSuggestionViewModel? = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: "error_word"),
                                                                            history: TestHistoryService(value: [], whenError: ""))
        let transform = viewModel?.transform(from: WordsSuggestionViewModel.Input(searchText: inputWords,
                                                                                  forHistory: inputWords,
                                                                                  removeHistory: inputRemovedWords))
        transform?.suggestions.drive(result).disposed(by: disposeBag)

        // Act
        viewModel = nil
        scheduler.start()

        // Assert
        XCTAssertEqual(result.events, [
            .next(200, SuggestionItemResult.success([])),
            .next(200, SuggestionItemResult.success([])),
            .next(250, SuggestionItemResult.success([])),
            .next(250, SuggestionItemResult.success([])),
            .next(300, SuggestionItemResult.success([])),
            .next(350, SuggestionItemResult.success([])),
            .completed(500)
        ])
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
    
    private func createSuggestionItems(_ data: [String], _ removable: Bool) -> [SuggestionItem] {
        var res = [SuggestionItem]()
        for item in data {
            res.append(SuggestionItem(suggestion: item, removable: removable))
        }
        return res
    }
    
    class TestHistoryService : HistoryService {
        private var data = [String]()
        private let errorWord: String
        
        init(value: [String], whenError errorWord: String) {
            self.data = value
            self.errorWord = errorWord
            super.init(storage: StorageStub())
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
                    self?.data.append(word)
                }
                observer.onNext(())
                observer.onCompleted()
                return Disposables.create {}
            }
        }
        
        override func remove(_ word: String) -> Observable<Void> {
            return Observable.create { [weak self] observer in
                if var data = self?.data, let index = data.firstIndex(of: word) {
                    data.remove(at: index)
                }
                observer.onNext(())
                observer.onCompleted()
                return Disposables.create {}
            }
        }
    }
}
