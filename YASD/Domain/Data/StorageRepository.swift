//
//  StorageService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 29.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import RxSwift

typealias StorageServiceResult = Result<Bool>

protocol StorageRepository {
    associatedtype T
    
    func get(where filterFunc: (@escaping (T) -> Bool)) -> Observable<Result<[T]>>
    func add(_ word: T) -> Observable<StorageServiceResult>
    func remove(_ word: T) -> Observable<StorageServiceResult>
    func remove(at index: Int) -> Observable<StorageServiceResult>
    func contains(_ word: T) -> Observable<StorageServiceResult>
    func getChangedSubject() -> PublishSubject<Bool>
}

class AnyStorageRepository<T: Codable & Equatable>: StorageRepository {
    private let getObject: (@escaping (T) -> Bool) -> Observable<Result<[T]>>
    private let addObject: (_ word: T) -> Observable<StorageServiceResult>
    private let removeObject: (_ word: T) -> Observable<StorageServiceResult>
    private let removeAtObject: (_ index: Int) -> Observable<StorageServiceResult>
    private let containsObject: (_ word: T) -> Observable<StorageServiceResult>
    private let getChangedSubjectObject: () -> PublishSubject<Bool>
    
    init<TypeStorageRepository: StorageRepository>(wrapped: TypeStorageRepository)
    where TypeStorageRepository.T == T {
        getObject = wrapped.get
        addObject = wrapped.add
        removeObject = wrapped.remove
        removeAtObject = wrapped.remove
        containsObject = wrapped.contains
        getChangedSubjectObject = wrapped.getChangedSubject
    }
    
    func get(where filterFunc: (@escaping (T) -> Bool)) -> Observable<Result<[T]>> {
        return getObject(filterFunc)
    }
    
    func add(_ word: T) -> Observable<StorageServiceResult> {
        return addObject(word)
    }
    
    func remove(_ word: T) -> Observable<StorageServiceResult> {
        return removeObject(word)
    }
    
    func remove(at index: Int) -> Observable<StorageServiceResult> {
        return removeAtObject(index)
    }
    
    func contains(_ word: T) -> Observable<StorageServiceResult> {
        return containsObject(word)
    }
    
    func getChangedSubject() -> PublishSubject<Bool> {
        return getChangedSubjectObject()
    }
}
