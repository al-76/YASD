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
        ]).asDriver(onErrorJustReturn: "")
        let foundWords = scheduler.createObserver(FormattedWordResult.self)
        let viewModel = WordsViewModel(lexin: createMockLexinService(whenError: errorWord),
                                       formatter: createMockLexinServiceFormatter(),
                                       player: createMockPlayerService())
        viewModel.transform(from: WordsViewModel.Input(searchBar: inputWords, playUrl: Driver.never()))
            .foundWords.drive(foundWords).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(foundWords.events, [
            .next(200, FormattedWordResult.success([FormattedWord(formatted: NSAttributedString(string: "test2"), soundUrl: nil)])),
            .next(250, FormattedWordResult.success([FormattedWord(formatted: NSAttributedString(string: "test3"), soundUrl: nil)])),
            .next(350, FormattedWordResult.failure(TestError.someError))
        ])
    }
    
    func testSearchErrorNilViewModel() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let inputWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .next(250, "test3"),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let foundWords = scheduler.createObserver(FormattedWordResult.self)
        var viewModel: WordsViewModel?  = WordsViewModel(lexin: createMockLexinService(whenError: "error_word"),
                                                         formatter: createMockLexinServiceFormatter(),
                                                         player: createMockPlayerService())
        viewModel?.transform(from: WordsViewModel.Input(searchBar: inputWords, playUrl: Driver.never()))
            .foundWords.drive(foundWords).disposed(by: disposeBag)
        
        // Act
        viewModel = nil
        scheduler.start()
        
        // Assert
        XCTAssertEqual(foundWords.events, [
            .next(200, FormattedWordResult.success([])),
            .next(250, FormattedWordResult.success([]))
        ])
    }
    
    func testSearchUpdateOnSwitchParameters() {
        // Arrange
        let errorWord = "error_word"
        let scheduler = TestScheduler(initialClock: 0)
        let inputWords = scheduler.createHotObservable([
            .next(200, "test2"),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let foundWords = scheduler.createObserver(FormattedWordResult.self)
        let lexin = createMockLexinService(whenError: errorWord)
        let viewModel = WordsViewModel(lexin: lexin,
                                       formatter: createMockLexinServiceFormatter(),
                                       player: createMockPlayerService())
        viewModel.transform(from: WordsViewModel.Input(searchBar: inputWords, playUrl: Driver.never()))
            .foundWords.drive(foundWords).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        lexin.language()
            .onNext(Language(name: "test2", code: "test2_code"))
        
        // Assert
        XCTAssertEqual(foundWords.events, [
            .next(200, FormattedWordResult.success([FormattedWord(formatted: NSAttributedString(string: "test2"), soundUrl: nil)])),
            .next(400, FormattedWordResult.success([FormattedWord(formatted: NSAttributedString(string: "test2"), soundUrl: nil)]))
        ])
    }
    
    func testPlay() {
        // Arrange
        let errorUrl = "error"
        let scheduler = TestScheduler(initialClock: 0)
        let inputUrls = scheduler.createHotObservable([
            .next(150, "some_url"),
            .next(200, "some_url_2"),
            .next(300, errorUrl),
            .completed(400)
        ]).asDriver(onErrorJustReturn: "")
        let played = scheduler.createObserver(PlayerServiceResult.self)
        let viewModel = WordsViewModel(lexin: createMockLexinService(whenError: ""),
                                       formatter: createMockLexinServiceFormatter(),
                                       player: createMockPlayerService(errorUrl: errorUrl))
        viewModel.transform(from: WordsViewModel.Input(searchBar: Driver.never(), playUrl: inputUrls))
            .played.drive(played)
            .disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(played.events, [
            .next(150, .success(true)),
            .next(200, .success(true)),
            .next(300, .failure(TestError.someError)),
            .completed(400)
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
            when(stub.search(any())).then { word in
                return Observable<LexinWordResult>.create { observable in
                    if word == errorWord {
                        observable.on(.error(TestError.someError))
                    } else if !word.isEmpty { // ignore initial search on loaded parameters
                        observable.on(.next(.success([LexinWord(word: word)])))
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
    
    func createMockLexinServiceFormatter() -> MockLexinServiceFormatter {
        let mock = MockLexinServiceFormatter(markdown: MockMarkdown())
        stub(mock) { stub in
            when(stub.format(result: any())).then { result in
                switch result {
                case .success(let items):
                    return .success(items.map { FormattedWord(formatted: NSAttributedString(string: $0.word), soundUrl: nil) })
                case .failure(let error):
                    return .failure(error)
                }
            }
        }
        return mock
    }
    
    func createMockPlayerService() -> MockPlayerService {
        return createMockPlayerService(errorUrl: "")
    }
    
    func createMockPlayerService(errorUrl: String) -> MockPlayerService {
        let mock = MockPlayerService(player: MockPlayer(), cache: MockCacheService(cache: MockDataCache(name: "test")), network: MockNetwork())
        stub(mock) { stub in
            when(stub.playSound(with: anyString())).then { stringUrl in
                return Observable<PlayerServiceResult>.create {
                    observable in
                    if stringUrl == errorUrl {
                        observable.on(.error(TestError.someError))
                    } else {
                        observable.on(.next(.success(true)))
                    }
                    observable.onCompleted()
                    return Disposables.create {}
                }
            }
        }
        return mock
    }
}
