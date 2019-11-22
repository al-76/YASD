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
    
    func testSuggestion() {
        // Arrange
        let errorWord = "error_word"
        let scheduler = TestScheduler(initialClock: 0)
        let inputWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .next(250, "test3"),
            .next(350, errorWord),
            .completed(400)
        ])
        let suggestions = scheduler.createObserver(LexinParserSuggestionResult.self)
        let viewModel = WordsSuggestionViewModel(lexin: createMockLexinService(errorWord: errorWord))
        viewModel.transform(input: WordsSuggestionViewModel.Input(searchBar: inputWords.asDriver(onErrorJustReturn: "")))
            .suggestions.drive(suggestions).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(suggestions.events, [
            .next(200, LexinParserSuggestionResult.success([ "test2" ])),
            .next(250, LexinParserSuggestionResult.success([ "test3" ])),
            .next(350, LexinParserSuggestionResult.failure(TestError.someError)),
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
        let suggestions = scheduler.createObserver(LexinParserSuggestionResult.self)
        var viewModel: WordsSuggestionViewModel? = WordsSuggestionViewModel(lexin: createMockLexinService(errorWord: "error_word"))
        viewModel?.transform(input: WordsSuggestionViewModel.Input(searchBar: inputWords.asDriver(onErrorJustReturn: "")))
            .suggestions.drive(suggestions).disposed(by: disposeBag)
        
        // Act
        viewModel = nil
        scheduler.start()
        
        // Assert
        XCTAssertEqual(suggestions.events, [
            .next(200, LexinParserSuggestionResult.success([])),
            .next(250, LexinParserSuggestionResult.success([])),
            .completed(400)
        ])
    }
    
    func createMockLexinService(errorWord: String) -> MockLexinService {
        let stubParameters = createLexinServiceParametersStub()
        let mockNetwork = MockNetworkService(cache: MockCacheService(cache: MockDataCache(name: "Test")),
                                                     network: MockNetwork())
        let mockApi = MockLexinApi(network: mockNetwork,
                                   parserWords: MockLexinParserWords(),
                                   parserSuggestions: MockLexinParserSuggestion())
        let mockProvider = MockLexinApiProvider(defaultApi: mockApi, folketsApi: mockApi, swedishApi: mockApi)
        let mock = MockLexinService(parameters: stubParameters, provider: mockProvider)
        stub(mock) { stub in
            when(stub.language()).thenReturn(stubParameters.language)
            when(stub.suggestion(word: any())).then { word in
                return Observable<LexinParserSuggestionResult>.create { observable in
                    if word == errorWord {
                        observable.on(.error(TestError.someError))
                    } else {
                        observable.on(.next(.success([ word ])))
                    }
                    observable.on(.completed)
                    return Disposables.create {}
                }
            }
        }
        return mock
    }
    
    private func createLexinServiceParametersStub() -> LexinServiceParametersStub {
        let language = LexinServiceParameters.Language(name: "test", code: "test")
        DefaultValueRegistry.register(value: language, forType: LexinServiceParameters.Language.self)
        let stub = LexinServiceParametersStub(storage: StorageStub(),
                                              language: language)
        return stub
    }
}
