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

class WordsTableViewModelTests: XCTestCase {
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
        let viewModel = WordsTableViewModel(lexin: createMockLexinService(errorWord: errorWord))
        viewModel.transform(input: WordsTableViewModel.Input(searchBar: inputWords.asDriver(onErrorJustReturn: "")))
            .foundWords.drive(foundWords).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(foundWords.events, [
            .next(200, LexinServiceResultFormatted.success([NSAttributedString(string: "test2")])),
            .next(250, LexinServiceResultFormatted.success([NSAttributedString(string: "test3")])),
            .next(350, LexinServiceResultFormatted.failure(TestError.someError)),
            .completed(400)
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
        var viewModel: WordsTableViewModel?  = WordsTableViewModel(lexin: createMockLexinService(errorWord: ""))
        viewModel?.transform(input: WordsTableViewModel.Input(searchBar: inputWords.asDriver(onErrorJustReturn: "")))
            .foundWords.drive(foundWords).disposed(by: disposeBag)
        
        // Act
        viewModel = nil
        scheduler.start()
        
        // Assert
        XCTAssertEqual(foundWords.events, [
            .next(200, LexinServiceResultFormatted.success([])),
            .next(250, LexinServiceResultFormatted.success([])),
            .completed(400)
            ])
    }
    
    func createMockLexinService(errorWord: String) -> MockLexinService {
        let mock = MockLexinService(network: MockNetwork(),
                                                htmlParser: MockHtmlParser(),
                                                parameters: MockLexinServiceParameters(from: "ru", to: "sv"),
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
