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
        let testLanguage = Language(name: "test", code: "test")
        let scheduler = TestScheduler(initialClock: 0)
        let inputLanguages = scheduler.createHotObservable([
            .next(150, testLanguage.name)
        ]).asDriver(onErrorJustReturn: "")
        let res = scheduler.createObserver([SettingsLanguageItem].self)
        let viewModel = SettingsLanguageViewModel(settings: createSettingsLanguageService(testLanguage))
        let output = viewModel.transform(from: SettingsLanguageViewModel.Input(search: Driver.just(""),
                                                                               select: inputLanguages))
        output.languages.drive(res)
            .disposed(by: disposeBag)

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(res.events, [
            .next(0, [ SettingsLanguageItem(selected: false, language: testLanguage) ]),
            .next(150, [ SettingsLanguageItem(selected: false, language: testLanguage) ])
        ])
    }
    
    func testSettingsLanguageSearch() {
        // Arrange
        let testLanguage = Language(name: "test", code: "test")
        let scheduler = TestScheduler(initialClock: 0)
        let inputLanguages = scheduler.createHotObservable([
            .next(150, testLanguage.name)
        ]).asDriver(onErrorJustReturn: "")
        let res = scheduler.createObserver([SettingsLanguageItem].self)
        let viewModel = SettingsLanguageViewModel(settings: createSettingsLanguageService(testLanguage))
        let output = viewModel.transform(from: SettingsLanguageViewModel.Input(search: inputLanguages,
                                                                               select: Driver.never()))
        output.languages.drive(res).disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(150, [ SettingsLanguageItem(selected: false, language: testLanguage) ])
        ])
    }

    
    private func createParametersStorageStub(_ language: Language) -> ParametersStorageStub {
        DefaultValueRegistry.register(value: language, forType: Language.self)
        let stub = ParametersStorageStub(storage: StorageStub(), language: language)
        return stub
    }
    
    private func createSettingsLanguageService(_ language: Language) -> MockSettingsLanguageService {
        let mock = MockSettingsLanguageService(parameters: createParametersStorageStub(Language(name: "test", code: "test")))
        stub(mock) { stub in
            when(stub.update(with: any())).thenReturn(Observable.just(.success(true)))
            when(stub.get(with: any())).thenReturn(Observable.just(
                .success([ SettingsLanguageItem(selected: false, language: language) ]
                )))
        }
        return mock
    }
}
