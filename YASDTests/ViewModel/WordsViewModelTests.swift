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
            .next(150, ""), // will be ignored
            .next(200, "test2"),
            .next(250, "test3"),
            .next(350, errorWord),
            .completed(400)
            ])
        let foundWords = scheduler.createObserver(LexinServiceResultFormatted.self)
        let viewModel = WordsViewModel(lexin: createMockLexinService(errorWord: errorWord))
        viewModel.transform(input: WordsViewModel.Input(searchBar: inputWords.asDriver(onErrorJustReturn: "")))
            .foundWords.drive(foundWords).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(foundWords.events, [
            .next(200, LexinServiceResultFormatted.success([NSAttributedString(string: "test2")])),
            .next(250, LexinServiceResultFormatted.success([NSAttributedString(string: "test3")])),
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
        var viewModel: WordsViewModel?  = WordsViewModel(lexin: createMockLexinService(errorWord: "error_word"))
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
        let viewModel = WordsViewModel(lexin: lexin)
        viewModel.transform(input: WordsViewModel.Input(searchBar: inputWords.asDriver(onErrorJustReturn: "")))
            .foundWords.drive(foundWords).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        lexin.parameters.language
            .accept(LexinServiceParameters.Language(name: "test2", code: "test2_code"))
        
        // Assert
        XCTAssertEqual(foundWords.events, [
            .next(200, LexinServiceResultFormatted.success([NSAttributedString(string: "test2")])),
            .next(400, LexinServiceResultFormatted.success([NSAttributedString(string: "test2")]))
            ])

    }
    
    func createMockLexinService(errorWord: String) -> MockLexinService {
        let mock = MockLexinService(network: MockNetwork(),
                                                htmlParser: MockHtmlParser(),
                                                parameters: LexinServiceParameters(language: MockLexinServiceParameters.Language(name: "test", code: "test")),
                                                formatter: createMockLexinServiceFormatter())
        stub(mock) { mock in
            when(mock.search(word: anyString())).then { word in
                return Observable<LexinServiceResult>.create { observable in
                    if word == errorWord {
                        observable.on(.error(TestError.someError))
                    } else if word.isEmpty {
                        observable.on(.completed)
                    } else {
                      observable.on(.next(.success([LexinServiceResultItem(word: word)])))
                    }
                    return Disposables.create {}
                }
            }
        }
        return mock
    }
    
    func createMockLexinServiceFormatter() -> MockLexinServiceFormatter {
        let mock = MockLexinServiceFormatter(markdown: MockMarkdown())
        stub(mock) { mock in
            when(mock.format(result: any())).then { result in
                switch result {
                case .success(let items):
                    return .success(items.map { NSAttributedString(string: $0.word) })
                case .failure(let error):
                    return .failure(error)
                }
            }
        }
        return mock
    }
}
