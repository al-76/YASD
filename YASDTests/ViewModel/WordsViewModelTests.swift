//
//  WordsTableViewModelTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 16/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//
@testable import YASD

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Cuckoo

class WordsViewModelTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    let disposeBag = DisposeBag()
    
    func testSearch() {
        // Arrange
        let errorWord = "error_word"
        let scheduler = TestScheduler(initialClock: 0)
        let inputWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .next(250, "test3"),
            .next(350, errorWord),
            .completed(400)
            ])
        let foundWords = scheduler.createObserver(LexinServiceResultFormatted.self)
        let viewModel = WordsViewModel(lexin: createMockLexinService(errorWord: errorWord),
                                       formatter: createMockLexinServiceFormatter(),
                                       player: createMockPlayerService())
        viewModel.transform(input: WordsViewModel.Input(searchBar: inputWords.asDriver(onErrorJustReturn: "")))
            .foundWords.drive(foundWords).disposed(by: disposeBag)

        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(foundWords.events, [
            .next(200, LexinServiceResultFormatted.success([ LexinServiceResultFormattedItem(formatted: NSAttributedString(string: "test2"), soundUrl: nil) ])),
            .next(250, LexinServiceResultFormatted.success([ LexinServiceResultFormattedItem(formatted: NSAttributedString(string: "test3"), soundUrl: nil) ])),
            .next(350, LexinServiceResultFormatted.failure(TestError.someError))
            ])
    }

    func testSearchErrorNilViewModel() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let inputWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .next(250, "test3"),
            .completed(400)
            ])
        let foundWords = scheduler.createObserver(LexinServiceResultFormatted.self)
        var viewModel: WordsViewModel?  = WordsViewModel(lexin: createMockLexinService(errorWord: "error_word"),
                                                         formatter: createMockLexinServiceFormatter(),
                                                         player: createMockPlayerService())
        viewModel?.transform(input: WordsViewModel.Input(searchBar: inputWords.asDriver(onErrorJustReturn: "")))
            .foundWords.drive(foundWords).disposed(by: disposeBag)

        // Act
        viewModel = nil
        scheduler.start()

        // Assert
        XCTAssertEqual(foundWords.events, [
            .next(200, LexinServiceResultFormatted.success([])),
            .next(250, LexinServiceResultFormatted.success([]))
            ])
    }

    func testSearchUpdateOnSwitchParameters() {
        // Arrange
        let errorWord = "error_word"
        let scheduler = TestScheduler(initialClock: 0)
        let inputWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .completed(400)
            ])
        let foundWords = scheduler.createObserver(LexinServiceResultFormatted.self)
        let lexin = createMockLexinService(errorWord: errorWord)
        let viewModel = WordsViewModel(lexin: lexin,
                                       formatter: createMockLexinServiceFormatter(),
                                       player: createMockPlayerService())
        viewModel.transform(input: WordsViewModel.Input(searchBar: inputWords.asDriver(onErrorJustReturn: "")))
            .foundWords.drive(foundWords).disposed(by: disposeBag)

        // Act
        scheduler.start()
        lexin.language()
            .onNext(LexinServiceParameters.Language(name: "test2", code: "test2_code"))

        // Assert
        XCTAssertEqual(foundWords.events, [
            .next(200, LexinServiceResultFormatted.success([ LexinServiceResultFormattedItem(formatted: NSAttributedString(string: "test2"), soundUrl: nil) ])),
            .next(400, LexinServiceResultFormatted.success([ LexinServiceResultFormattedItem(formatted: NSAttributedString(string: "test2"), soundUrl: nil) ]))
            ])
    }

    func testNewCell() {
        // Arrange
        let viewModel = WordsViewModel(lexin: createMockLexinService(errorWord: "test"),
                                       formatter: createMockLexinServiceFormatter(),
                                       player: createMockPlayerService())
        let cell = viewModel.newCell()

        XCTAssertNotNil(cell)
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
            when(stub.search(word: any())).then { word in
                return Observable<LexinParserWordsResult>.create { observable in
                    if word == errorWord {
                        observable.on(.error(TestError.someError))
                    } else if word.isEmpty { // ignore initial search on loaded parameters
                        observable.on(.completed)
                    } else {
                        observable.on(.next(.success([ LexinParserWordsResultItem(word: word) ])))
                    }
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
    
    func createMockLexinServiceFormatter() -> MockLexinServiceFormatter {
        let mock = MockLexinServiceFormatter(markdown: MockMarkdown())
        stub(mock) { stub in
            when(stub.format(result: any())).then { result in
                switch result {
                case .success(let items):
                    return .success(items.map { LexinServiceResultFormattedItem(formatted: NSAttributedString(string: $0.word), soundUrl: nil) })
                case .failure(let error):
                    return .failure(error)
                }
            }
        }
        return mock
    }
    
    func createMockPlayerService() -> MockPlayerService {
        return MockPlayerService(player: MockPlayer(), cache: MockCacheService(cache: MockDataCache(name: "test")), network: MockNetwork())
    }
}
