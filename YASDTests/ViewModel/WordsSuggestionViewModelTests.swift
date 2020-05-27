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
            .next(250, "test3")
        ]).asDriver(onErrorJustReturn: "")
        let result = scheduler.createObserver(SuggestionItemResult.self)
        let viewModel = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: errorWord),
                                                 history: TestStorageService(value: []))
        viewModel.transform(from: WordsSuggestionViewModel.Input(search: inputWords,
                                                                 addHistory: Driver.never(),
                                                                 removeHistory: Driver.never()))
            .suggestions.drive(result)
            .disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(result.events, [
            .next(200, SuggestionItemResult.success(createSuggestionItems(["test2"], false))),
            .next(250, SuggestionItemResult.success(createSuggestionItems(["test3"], false)))
       ])
    }
    
    func testGetHistory() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let inputWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .next(250, "test3")
        ]).asDriver(onErrorJustReturn: "")
        let initialValue = ["test2", "test3_abc", "test3_cde", "some_words"]
        let result = scheduler.createObserver(SuggestionItemResult.self)
        let viewModel = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: ""),
                                                 history: TestStorageService(value: initialValue))
        viewModel.transform(from: WordsSuggestionViewModel.Input(search: inputWords,
                                                                 addHistory: Driver.never(),
                                                                 removeHistory: Driver.never()))
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
            ]))
        ])
    }
    
    func testSaveHistory() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let historyWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .next(250, "test3")
        ]).asDriver(onErrorJustReturn: "")
        let result = scheduler.createObserver(SuggestionItemResult.self)
        let viewModel = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: "error_word"),
                                                 history: TestStorageService(value: []))
        viewModel.transform(from: WordsSuggestionViewModel.Input(search: Driver.never(),
                                                                 addHistory: historyWords, removeHistory: Driver.never()))
            .suggestions.drive(result)
            .disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(result.events, [
            .next(200, SuggestionItemResult.success(createSuggestionItems(["test2"], true))),
            .next(250, SuggestionItemResult.success(createSuggestionItems(["test3"], true))),
        ])
    }
    
    func testRemoveHistory() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let inputRemovedWords = scheduler.createHotObservable([
            .next(200, "test3")
        ]).asDriver(onErrorJustReturn: "")
        let result = scheduler.createObserver(SuggestionItemResult.self)
        let viewModel = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: "error_word"),
                                                 history: TestStorageService(value: ["test2", "test3"]))
        viewModel.transform(from: WordsSuggestionViewModel.Input(search: Driver.just(""),
                                                                 addHistory: Driver.never(),
                                                                 removeHistory: inputRemovedWords))
            .suggestions.drive(result)
            .disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(result.events, [
            .next(0, SuggestionItemResult.success([
                SuggestionItem(suggestion: "", removable: false),
                SuggestionItem(suggestion: "test2", removable: true),
                SuggestionItem(suggestion: "test3", removable: true)
            ])),
            .next(200, SuggestionItemResult.success([
                SuggestionItem(suggestion: "", removable: false),
                SuggestionItem(suggestion: "test2", removable: true)
            ])),
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
            .next(300, "test2"),
            .next(350, "test3"),
            .completed(500)
        ]).asDriver(onErrorJustReturn: "")
        let result = scheduler.createObserver(SuggestionItemResult.self)
        var viewModel: WordsSuggestionViewModel? = WordsSuggestionViewModel(lexin: createMockLexinService(whenError: "error_word"),
                                                                            history: TestStorageService(value: []))
        let transform = viewModel?.transform(from: WordsSuggestionViewModel.Input(search: inputWords,
                                                                                  addHistory: inputWords,
                                                                                  removeHistory: inputRemovedWords))
        transform?.suggestions.drive(result)
            .disposed(by: disposeBag)

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
    
    class TestStorageService : StorageService<Suggestion> {
        private var data = [Suggestion]()
        
        init(value: [Suggestion]) {
            self.data = value
            super.init(id: "test", storage: StorageStub())
        }
        
        override func get(where filterFunc: @escaping (Suggestion) -> Bool) -> Observable<Result<[Suggestion]>> {
            return Observable.create { [weak self] observer in
                if let data = self?.data {
                    observer.onNext(SuggestionResult.success(data.filter(filterFunc)))
                } else {
                    observer.onNext(SuggestionResult.success([]))
                }
                observer.onCompleted()

                return Disposables.create {}
            }
        }
        
        override func add(_ word: Suggestion) -> Observable<StorageServiceResult> {
            return Observable.create { [weak self] observer in
                if !(word?.isEmpty ?? false) {
                    self?.data.append(word)
                }
                observer.onNext(.success(true))
                observer.onCompleted()
                return Disposables.create {}
            }
        }
        
        override func remove(_ word: Suggestion) -> Observable<StorageServiceResult> {
            return Observable.create { [weak self] observer in
                if let index = self?.data.firstIndex(of: word) {
                    self?.data.remove(at: index)
                }
                observer.onNext(.success(true))
                observer.onCompleted()
                return Disposables.create {}
            }
        }
    }
}
