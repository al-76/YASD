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
    
    func get(where filterFunc: @escaping (T) -> Bool) -> Observable<Result<[T]>>
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
    
    func get(where filterFunc: @escaping (T) -> Bool) -> Observable<Result<[T]>> {
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

//class DefaultStorageRepository<T: Codable & Equatable>: PStorageRepository {
//    let changed = PublishSubject<Bool>()
//
//    private let id: String
//    private let storage: Storage
//
//    private lazy var data: [T] = {
//        return self.storage.get(id: id, defaultObject: [T]())
//    }()
//
//    init(id: String, storage: Storage) {
//        self.id = id
//        self.storage = storage
//    }
//
//    func get(where filterFunc: @escaping (T) -> Bool) -> Observable<Result<[T]>> {
//        return Observable.create { [weak self] observer in
//            if let data = self?.data {
//                let filtered = data.filter(filterFunc)
//                observer.onNext(.success(filtered))
//            } else {
//                observer.onNext(.success([]))
//            }
//            observer.onCompleted()
//            return Disposables.create {}
//        }
//    }
//
//    func add(_ word: T) -> Observable<StorageServiceResult> {
//        return Observable.create { [weak self] observer in
//            do {
//                if self?.data.firstIndex(where: { $0 == word }) == nil { // yes yes, I know about ordered set
//                    self?.data.insert(word, at: 0)
//                    try self?.saveData()
//                }
//                observer.onNext(.success(true))
//                observer.onCompleted()
//            } catch let error {
//                observer.onNext(.failure(error))
//            }
//            return Disposables.create {}
//        }
//    }
//
//    func remove(_ word: T) -> Observable<StorageServiceResult> {
//        return Observable.create { [weak self] observer in
//            do {
//                self?.data.removeAll(where: { $0 == word })
//                try self?.saveData()
//                observer.onNext(.success(true))
//                observer.onCompleted()
//            } catch let error {
//                observer.onNext(.failure(error))
//            }
//            return Disposables.create {}
//        }
//    }
//
//    func remove(at index: Int) -> Observable<StorageServiceResult> {
//        return Observable.create { [weak self] observer in
//            do {
//                self?.data.remove(at: index)
//                try self?.saveData()
//                observer.onNext(.success(true))
//                observer.onCompleted()
//            } catch let error {
//                observer.onNext(.failure(error))
//            }
//            return Disposables.create {}
//        }
//    }
//
//    func contains(_ word: T) -> Observable<StorageServiceResult> {
//        return Observable.create { [weak self] observer in
//            observer.onNext(.success(self?.data.contains(word) ?? false))
//            observer.onCompleted()
//            return Disposables.create {}
//        }
//    }
//
//    private func saveData() throws {
//        try storage.save(id: id, object: data)
//        changed.onNext(true)
//    }
//}
//
//class StorageRepository<T: Codable & Equatable> {
//    let changed = PublishSubject<Bool>()
//
//    private let id: String
//    private let storage: Storage
//
//    private lazy var data: [T] = {
//        return self.storage.get(id: id, defaultObject: [T]())
//    }()
//
//    init(id: String, storage: Storage) {
//        self.id = id
//        self.storage = storage
//    }
//
//    func get(where filterFunc: @escaping (T) -> Bool) -> Observable<Result<[T]>> {
//        return Observable.create { [weak self] observer in
//            if let data = self?.data {
//                let filtered = data.filter(filterFunc)
//                observer.onNext(.success(filtered))
//            } else {
//                observer.onNext(.success([]))
//            }
//            observer.onCompleted()
//            return Disposables.create {}
//        }
//    }
//
//    func add(_ word: T) -> Observable<StorageServiceResult> {
//        return Observable.create { [weak self] observer in
//            do {
//                if self?.data.firstIndex(where: { $0 == word }) == nil { // yes yes, I know about ordered set
//                    self?.data.insert(word, at: 0)
//                    try self?.saveData()
//                }
//                observer.onNext(.success(true))
//                observer.onCompleted()
//            } catch let error {
//                observer.onNext(.failure(error))
//            }
//            return Disposables.create {}
//        }
//    }
//
//    func remove(_ word: T) -> Observable<StorageServiceResult> {
//        return Observable.create { [weak self] observer in
//            do {
//                self?.data.removeAll(where: { $0 == word })
//                try self?.saveData()
//                observer.onNext(.success(true))
//                observer.onCompleted()
//            } catch let error {
//                observer.onNext(.failure(error))
//            }
//            return Disposables.create {}
//        }
//    }
//
//    func remove(at index: Int) -> Observable<StorageServiceResult> {
//        return Observable.create { [weak self] observer in
//            do {
//                self?.data.remove(at: index)
//                try self?.saveData()
//                observer.onNext(.success(true))
//                observer.onCompleted()
//            } catch let error {
//                observer.onNext(.failure(error))
//            }
//            return Disposables.create {}
//        }
//    }
//
//    func contains(_ word: T) -> Observable<StorageServiceResult> {
//        return Observable.create { [weak self] observer in
//            observer.onNext(.success(self?.data.contains(word) ?? false))
//            observer.onCompleted()
//            return Disposables.create {}
//        }
//    }
//
//    private func saveData() throws {
//        try storage.save(id: id, object: data)
//        changed.onNext(true)
//    }
//}
