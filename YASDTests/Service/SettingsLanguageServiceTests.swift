////
////  SettingsLanguageServiceTests.swift
////  YASDTests
////
////  Created by Vyacheslav Konopkin on 27.12.2019.
////  Copyright © 2019 yac. All rights reserved.
////
//
//@testable import YASD
//
//import XCTest
//import RxSwift
//import RxTest
//import Cuckoo
//
//class SettingsLanguageServiceTests: XCTestCase {
//
//    func testUpdate() {
//        // Arrange
//        let testLanguage = ParametersStorage.supportedLanguages[1]
//        let scheduler = TestScheduler(initialClock: 0)
//        let service = SettingsLanguageService(parameters: createParametersStorageStub())
//        
//        // Act
//        let updated = service.update(with: testLanguage.name)
//        let res = scheduler.start { updated }
//        
//        // Assert
//        XCTAssertEqual(res.events, [
//            .next(200, SettingsLanguageResult.success(true)),
//            .completed(200)
//        ])
//    }
//    
//    func testGet() {
//        // Arrange
//        let testLanguage = ParametersStorage.supportedLanguages[1]
//        let scheduler = TestScheduler(initialClock: 0)
//        let service = SettingsLanguageService(parameters: createParametersStorageStub())
//        
//        // Act
//        let updated = service.get(with: testLanguage.name)
//        let res = scheduler.start { updated }
//        
//        // Assert
//        XCTAssertEqual(res.events, [
//            .next(200, SettingsLanguageItemResult.success([ SettingsLanguageItem(selected: false, language: testLanguage) ])),
//            .completed(200)
//        ])
//    }
//
//    private func createParametersStorageStub() -> ParametersStorageStub {
//        let language = ParametersStorage.defaultLanguage
//        DefaultValueRegistry.register(value: language, forType: Language.self)
//        let stub = ParametersStorageStub(storage: StorageStub(),
//                                         language: language)
//        return stub
//    }
//}
