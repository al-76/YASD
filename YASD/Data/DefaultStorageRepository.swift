//
//  DefaultStorageRepository.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 02.11.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import Foundation
import RxSwift

class DefaultStorageRepository<T: Codable & Equatable>: StorageRepository {
    private let changed = PublishSubject<Bool>()
    private let id: String
    private let storage: Storage
    
    private lazy var data: [T] = {
        return self.storage.get(id: id, defaultObject: [T]())
    }()
    
    init(id: String, storage: Storage) {
        self.id = id
        self.storage = storage
    }
    
    func get(where filterFunc: @escaping (T) -> Bool) -> Observable<Result<[T]>> {
        return Observable.create { [weak self] observer in
            if let data = self?.data {
                let filtered = data.filter(filterFunc)
                observer.onNext(.success(filtered))
            } else {
                observer.onNext(.success([]))
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func add(_ word: T) -> Observable<StorageServiceResult> {
        return Observable.create { [weak self] observer in
            do {
                if self?.data.firstIndex(where: { $0 == word }) == nil { // yes yes, I know about ordered set
                    self?.data.insert(word, at: 0)
                    try self?.saveData()
                }
                observer.onNext(.success(true))
                observer.onCompleted()
            } catch let error {
                observer.onNext(.failure(error))
            }
            return Disposables.create {}
        }
    }
    
    func remove(_ word: T) -> Observable<StorageServiceResult> {
        return Observable.create { [weak self] observer in
            do {
                self?.data.removeAll(where: { $0 == word })
                try self?.saveData()
                observer.onNext(.success(true))
                observer.onCompleted()
            } catch let error {
                observer.onNext(.failure(error))
            }
            return Disposables.create {}
        }
    }
    
    func remove(at index: Int) -> Observable<StorageServiceResult> {
        return Observable.create { [weak self] observer in
            do {
                self?.data.remove(at: index)
                try self?.saveData()
                observer.onNext(.success(true))
                observer.onCompleted()
            } catch let error {
                observer.onNext(.failure(error))
            }
            return Disposables.create {}
        }
    }
    
    func contains(_ word: T) -> Observable<StorageServiceResult> {
        return Observable.create { [weak self] observer in
            observer.onNext(.success(self?.data.contains(word) ?? false))
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getChangedSubject() -> PublishSubject<Bool> {
        return changed
    }
    
    private func saveData() throws {
        try storage.save(id: id, object: data)
        changed.onNext(true)
    }
}
