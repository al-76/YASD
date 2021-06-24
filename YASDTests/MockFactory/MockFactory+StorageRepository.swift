//
//  MockFactory+StorageRepository.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 24.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import RxSwift
import Cuckoo

extension MockFactory {
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
    
    static func createSuggestionStorageRepository(_ value: String) -> AnyStorageRepository<Suggestion> {
        return AnyStorageRepository<Suggestion>(wrapped: FakeStorageRepository(testValue: value))
    }
}
