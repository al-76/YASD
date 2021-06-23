//
//  AddSuggestionUseCaseTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 23.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//
@testable import YASD

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Cuckoo

class AddSuggestionUseCaseTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)
    
    func testExecute() {
        // Arrange
        let testValue = "test"
        let outputItems = scheduler.createObserver(SuggestionItemResult.self)
        let useCase = AddSuggestionUseCase(suggestions: createMockDictionaryRepository(),
                                           settings: MockFactory.createMockSettingsRepository(PublishSubject<Language>()),
                                           history: createStorageRepository(testValue))
        let res = useCase.execute(with: "")
        disposeBag.insert(
            res.bind(to: outputItems)
        )
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputItems.events, [
            .next(0, .success([SuggestionItem(suggestion: testValue, removable: true)])),
            .completed(0)
        ])
    }
    
    private func createMockDictionaryRepository() -> MockAnyDictionaryRepository<SuggestionResult> {
        let mock = MockAnyDictionaryRepository<SuggestionResult>(wrapped: MockDictionaryRepository())
        stub(mock) { stub in
            when(stub.search(any(), any())).then { _ in .just(.success([Suggestion("test")])) }
        }
        return mock
    }
    
    // FIXME: Cuckoo doesn't support @escaping protocols methods
    class FakeStorageRepository : StorageRepository {
        typealias T = Suggestion
        
        private let testValue: T
        
        init(testValue: String) {
            self.testValue = Suggestion(testValue)
        }
        
        func get(where filterFunc: (@escaping (T) -> Bool)) -> Observable<Result<[T]>> {
            return .just(.success([testValue]))
        }
        func add(_ word: T) -> Observable<StorageServiceResult> {
            return .just(.success(true))
        }
        func remove(_ word: T) -> Observable<StorageServiceResult> {
            return .just(.success(true))
        }
        func remove(at index: Int) -> Observable<StorageServiceResult> {
            .just(.success(true))
        }
        func contains(_ word: T) -> Observable<StorageServiceResult> {
            .just(.success(true))
        }
        func getChangedSubject() -> PublishSubject<Bool> {
            return PublishSubject<Bool>()
        }
    }
    
    func createStorageRepository(_ value: String) -> AnyStorageRepository<Suggestion> {
        return AnyStorageRepository<Suggestion>(wrapped: FakeStorageRepository(testValue: value))
    }
}

