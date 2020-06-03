//
//  WordsServiceTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 26/12/2019.
//  Copyright © 2019 yac. All rights reserved.
//

@testable import YASD

import XCTest
import RxSwift
import RxTest
import Cuckoo

class WordsServiceTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    func testSearch() {
        // Arrange
        let testData = "test"
        let scheduler = TestScheduler(initialClock: 0)
        let service = WordsService(lexin: createMockLexinRepository(),
                                   formatter: createMockLexinServiceFormatter(),
                                   bookmarks: createBookmarksStub())
        
        // Act
        let found = service.search(testData)
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, FoundWordResult.success([FoundWord(testData)])),
            .completed(200)
        ])
    }
    
    func testSearchError() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let service = WordsService(lexin: createMockLexinRepositoryError(),
                                   formatter: createMockLexinServiceFormatter(),
                                   bookmarks: createBookmarksStub())
        
        // Act
        let found = service.search("test")
        let res = scheduler.start { found }
        
        // Assert
        XCTAssertEqual(res.events, [
            .next(200, FoundWordResult.failure(TestError.someError)),
            .completed(200)
        ])
    }
    
    func testLanguage() {
        // Arrange
        let scheduler = TestScheduler(initialClock: 0)
        let service = WordsService(lexin: createMockLexinRepository(),
                                   formatter: createMockLexinServiceFormatter(),
                                   bookmarks: createBookmarksStub())
        
        // Act
        let language = service.language()
        let res = scheduler.start { language }
        
        // Assert
        XCTAssertFalse(res.events.isEmpty)
    }
    
    private func createMockLexinRepository() -> MockLexinRepository {
        let mock = MockLexinRepository()
        stub(mock) { stub in
            when(stub.language()).thenReturn(BehaviorSubject(value: ParametersStorage.defaultLanguage))
            when(stub.search(any())).then { word in
                return Observable<LexinWordResult>.create { observable in
                    observable.on(.next(.success([LexinWord(word: word)])))
                    observable.onCompleted()
                    return Disposables.create {}
                }
            }
        }
        return mock
    }
    
    private func createMockLexinRepositoryError() -> MockLexinRepository {
        let mock = MockLexinRepository()
        stub(mock) { stub in
            when(stub.search(any())).then { word in
                return Observable<LexinWordResult>.create { observable in
                    observable.on(.next(.failure(TestError.someError)))
                    observable.onCompleted()
                    return Disposables.create {}
                }
            }
        }
        return mock
    }
    
    private func createMockLexinServiceFormatter() -> MockLexinServiceFormatter {
        let mock = MockLexinServiceFormatter()
        stub(mock) { stub in
            when(stub.format(result: any())).then { result in
                switch result {
                case .success(let items):
                    return .success(items.map { FormattedWord(header: $0.word,
                                                              formatted: NSAttributedString(string: $0.word),
                                                              soundUrl: nil,
                                                              definition: "") })
                case .failure(let error):
                    return .failure(error)
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
    
    private func createBookmarksStub() -> StorageServiceStub<FormattedWord> {
        DefaultValueRegistry.register(value: Observable.just(.success(true)), forType:  Observable<StorageServiceResult>.self)
        return StorageServiceStub<FormattedWord>(id: "bookmarks", storage: StorageStub())
    }
}
