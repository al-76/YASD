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

class SettingsViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    func testSelectLanguage() {
        // Arrange
        let testValues = [
            LexinServiceParameters.Language(name: "initTestLanguage", code: "initTestCode"),
            LexinServiceParameters.Language(name: "testLanguage", code: "testCode"),
        ]
        let scheduler = TestScheduler(initialClock: 0)
        let inputLanguages = scheduler.createHotObservable([
            .next(150, testValues[1])
            ])
        let outputSelectedLanguages = scheduler.createObserver(String.self)
        let parameters = createLexinServiceParameters(language: testValues[0])
        inputLanguages.bind(to: parameters.language).disposed(by: disposeBag)
        let viewModel = SettingsViewModel(lexinParameters: parameters)
        let output = viewModel.transform(input: SettingsViewModel.Input())
        output.selectedLanguage.drive(outputSelectedLanguages).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputSelectedLanguages.events, [
            .next(0, testValues[0].name),
            .next(150, testValues[1].name)
            ])
    }
    
    fileprivate func createLexinServiceParameters(language: LexinServiceParameters.Language) -> MockLexinServiceParameters {
        let mock = MockLexinServiceParameters(storage: MockStorage(), language: language)
        stub(mock) { stub in
            when(stub.load()).thenDoNothing()
        }
        return mock
    }
}
