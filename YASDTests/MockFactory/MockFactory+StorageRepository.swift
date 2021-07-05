//
//  MockFactory+StorageRepository.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 24.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import Cuckoo
import RxSwift

extension MockFactory {
    // FIXME: Cuckoo doesn't support @escaping protocols methods
    private class SuggestionFakeStorageRepository: StorageRepository {
        // swiftlint:disable nesting
        typealias T = Suggestion

        private let testValue: T
        private let testSize: Int64

        init(testValue: String, testSize: Int64) {
            self.testValue = Suggestion(testValue)
            self.testSize = testSize
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
            return PublishSubject<Bool>()
        }

        func getSize() -> Observable<Int64> {
            return .just(testSize)
        }
    }

    private class FormattedWordStorageRepository: StorageRepository {
        // swiftlint:disable nesting
        typealias T = FormattedWord

        private let testValue: T
        private let publishSubject: PublishSubject<Bool>

        init(testValue: String, publishSubject: PublishSubject<Bool>) {
            self.testValue = FormattedWord(testValue)
            self.publishSubject = publishSubject
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
            return publishSubject
        }

        func getSize() -> Observable<Int64> {
            return .just(0)
        }
    }

    static func createSuggestionStorageRepository(_ value: String, _ size: Int64) -> AnyStorageRepository<Suggestion> {
        return AnyStorageRepository<Suggestion>(wrapped:
                                                    SuggestionFakeStorageRepository(testValue: value,
                                                                                    testSize: size))
    }

    // swiftlint:disable line_length
    static func createFormattedWordStorageRepository(_ value: String,
                                                     _ publishSubject: PublishSubject<Bool>) -> AnyStorageRepository<FormattedWord> {
        return AnyStorageRepository<FormattedWord>(wrapped:
                                                    FormattedWordStorageRepository(testValue: value,
                                                                                   publishSubject: publishSubject))
    }
}
