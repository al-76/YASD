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
import RxCocoa
import RxTest
import Cuckoo

class SettingsLanguageViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    func testSettingsLanguageSelect() {
        // Arrange
        let testLanguages = [
            ParametersStorage.defaultLanguage,
            ParametersStorage.supportedLanguages[0]
        ]
        let scheduler = TestScheduler(initialClock: 0)
        let inputLanguages = scheduler.createHotObservable([
            .next(150, testLanguages[1].name)
        ]).asDriver(onErrorJustReturn: "")
        let outputLanguages = scheduler.createObserver([SettingsItem].self)
        let parameters = createParametersStorageStub(testLanguages[0])
        let viewModel = SettingsLanguageViewModel(lexinParameters: parameters)
        let output = viewModel.transform(from: SettingsLanguageViewModel.Input(search: Driver.never(),
                                                                               select: inputLanguages))
        output.languages.drive(outputLanguages).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        for (index, event) in outputLanguages.events.enumerated() {
            XCTAssertEqual(getSelectedItem(from: event.value.element!)!.language.name, testLanguages[index].name)
        }
    }
    
    func testSettingsLanguageSearch() {
        // Arrange
        let searchLanguage = [
            ParametersStorage.defaultLanguage,
            ParametersStorage.supportedLanguages[0]
        ]
        let scheduler = TestScheduler(initialClock: 0)
        let inputLanguages = scheduler.createHotObservable([
            .next(100, searchLanguage[0].name),
            .next(150, searchLanguage[1].name)
        ]).asDriver(onErrorJustReturn: "")
        let outputLanguages = scheduler.createObserver([SettingsItem].self)
        let parameters = createParametersStorageStub(searchLanguage[0])
        let viewModel = SettingsLanguageViewModel(lexinParameters: parameters)
        let output = viewModel.transform(from: SettingsLanguageViewModel.Input(search: inputLanguages,
                                                                               select: Driver.never()))
        output.languages.drive(outputLanguages).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        for (index, event) in outputLanguages.events.dropFirst().enumerated() {
            XCTAssertEqual(event.value.element?.first?.language.name, searchLanguage[index].name)
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
