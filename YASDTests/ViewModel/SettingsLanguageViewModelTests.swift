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
            ParametersStorage.defaultLanguage,
            ParametersStorage.supportedLanguages[0]
        ]
        let scheduler = TestScheduler(initialClock: 0)
        let inputLanguages = scheduler.createHotObservable([
            .next(150, testLanguages[1].name)
        ])
        let outputLanguages = scheduler.createObserver([SettingsItem].self)
        let parameters = createParametersStorageStub(testLanguages[0])
        let viewModel = SettingsLanguageViewModel(lexinParameters: parameters)
        let output = viewModel.transform(from: SettingsLanguageViewModel.Input(selectedLanguage: inputLanguages.asDriver(onErrorJustReturn: "")))
        output.languages.drive(outputLanguages).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        for (index, event) in outputLanguages.events.enumerated() {
            XCTAssertEqual(getSelectedItem(from: event.value.element!)!.language.name, testLanguages[index].name)
        }
    }
    
    private func getSelectedItem(from items: [SettingsItem]) -> SettingsItem? {
        return items.first(where: { $0.selected })
    }
    
    private func createParametersStorageStub(_ language: Language) -> ParametersStorageStub {
        DefaultValueRegistry.register(value: language, forType: Language.self)
        let stub = ParametersStorageStub(storage: StorageStub(), language: language)
        return stub
    }
}
