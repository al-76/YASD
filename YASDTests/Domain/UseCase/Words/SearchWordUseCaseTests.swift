//
//  SearchWordUseCaseTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 18.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import Cuckoo
import RxCocoa
import RxSwift
import RxTest
import XCTest

class SearchWordUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    func testExecute() {
        // Arrange
        let testValue = "test"
        let outputItems = scheduler.createObserver(FoundWordResult.self)
        let inputChangedLanguage = scheduler.createHotObservable([
            .next(150, Language(name: "test", code: "test"))
        ])
        let inputChangedBookmarks = scheduler.createHotObservable([
            .next(160, true)
        ])
        let changedLanguage = PublishSubject<Language>()
        let changedBookmarks = PublishSubject<Bool>()
        let useCase = SearchWordUseCase(words: createMockDictionaryRepository(),
                                        settings: MockFactory.createMockSettingsRepository(changedLanguage),
                                        bookmarks: createStorageRepository(testValue, changedBookmarks))
        let res = useCase.execute(with: ("", ActivityIndicator()))
        disposeBag.insert(
            inputChangedLanguage.bind(to: changedLanguage),
            inputChangedBookmarks.bind(to: changedBookmarks),
            res.bind(to: outputItems)
        )

        // Act
        scheduler.start()

        // Assert
        let expectedValue = [FoundWord(testValue)]
        XCTAssertEqual(outputItems.events, [
            .next(0, .success(expectedValue)),
            .next(150, .success(expectedValue)),
            .next(160, .success(expectedValue))
        ])
    }

    private func createMockDictionaryRepository() -> MockAnyDictionaryRepository<FoundWordResult> {
        let mock = MockAnyDictionaryRepository<FoundWordResult>(wrapped: MockDictionaryRepository())
        stub(mock) { stub in
            when(stub.search(any(), any())).then { _ in .just(.success([FoundWord("test")])) }
        }
        return mock
    }

    // FIXME: Cuckoo doesn't support @escaping protocols methods
    class FakeStorageRepository: StorageRepository {
        // swiftlint:disable nesting
        typealias T = FormattedWord

        private let testValue: T
        private let testPublishSubject: PublishSubject<Bool>

        init(testValue: String, testPublishSubject: PublishSubject<Bool>) {
            self.testValue = FormattedWord(testValue)
            self.testPublishSubject = testPublishSubject
        }

        func get(where _: @escaping (T) -> Bool) -> Observable<Result<[T]>> {
            return .just(.success([testValue]))
        }

        func add(_: T) -> Observable<StorageServiceResult> {
            return .just(.success(true))
        }

        func remove(_: T) -> Observable<StorageServiceResult> {
            return .just(.success(true))
        }

        func remove(at _: Int) -> Observable<StorageServiceResult> {
            .just(.success(true))
        }

        func removeAll() -> Observable<StorageServiceResult> {
            return .just(.success(true))
        }

        func contains(_: T) -> Observable<StorageServiceResult> {
            .just(.success(true))
        }

        func getChangedSubject() -> PublishSubject<Bool> {
            return testPublishSubject
        }

        func getSize() -> Observable<Int64> {
            return .just(0)
        }
    }

    func createStorageRepository(_ value: String,
                                 _ publishSubject: PublishSubject<Bool>) -> AnyStorageRepository<FormattedWord> {
        return AnyStorageRepository<FormattedWord>(wrapped: FakeStorageRepository(testValue: value,
                                                                                  testPublishSubject: publishSubject))
    }
}
