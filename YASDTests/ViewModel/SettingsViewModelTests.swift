//
//  SettingsViewModel.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 05/08/2019.
//  Copyright © 2019 yac. All rights reserved.
//

@testable import YASD

import XCTest
import RxSwift
import RxTest
import Cuckoo

class SettingsViewModel: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    let disposeBag = DisposeBag()
    
    func testSelectLanguage() {
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
        let selectedLanguages = scheduler.createObserver(String.self)
        let viewModel = SettingsViewModel(lexinParameters: MockLexinServiceParameters(language: LexinServiceParameters.Language(name: "test", code: "test")))
//        viewModel.transform(input: WordsViewModel.Input(searchBar: inputWords.asDriver(onErrorJustReturn: "")))
//            .foundWords.drive(foundWords).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
//        XCTAssertEqual(selectedLanguages.events, [
//            .next(200, "test2"),
//            .next(250, "test3"),
//            .next(350, TestError.someError),
//            .completed(400)
//            ])
    }
}
