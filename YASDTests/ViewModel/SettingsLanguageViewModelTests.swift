//
//  SettingsLanguageViewModelTests.swift
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

class SettingsLanguageViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    func testSettingsLanguage() {
        // Arrange
        let testLanguages = [
            LexinServiceParameters.defaultLanguage,
            LexinServiceParameters.supportedLanguages[0]
            ]
        let scheduler = TestScheduler(initialClock: 0)
        let inputLanguages = scheduler.createHotObservable([
            .next(150, testLanguages[1].name)
            ])
        let outputLanguages = scheduler.createObserver([SettingsLanguageViewModel.SettingsItem].self)
        let parameters = createLexinServiceParameters(language: testLanguages[0])
        let viewModel = SettingsLanguageViewModel(lexinParameters: parameters)
        let output = viewModel.transform(input: SettingsLanguageViewModel.Input(selectedLanguage: inputLanguages.asDriver(onErrorJustReturn: "")))
        output.languages.drive(outputLanguages).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        for (index, event) in outputLanguages.events.enumerated() {
            XCTAssertEqual(getSelectedItem(items: event.value.element!)!.language.name, testLanguages[index].name)
        }
    }
    
    private func getSelectedItem(items: [SettingsLanguageViewModel.SettingsItem]) -> SettingsLanguageViewModel.SettingsItem? {
        return items.first(where: { $0.selected })
    }
    
    private func createLexinServiceParameters(language: LexinServiceParameters.Language) -> MockLexinServiceParameters {
        let mock = MockLexinServiceParameters(storage: MockStorage(), language: language)
        stub(mock) { stub in
            when(stub.load()).thenDoNothing()
            when(stub.setLanguage(language: any())).thenDoNothing()
            when(stub.getLanguage()).thenReturn(language)
        }
        return mock
    }
}
