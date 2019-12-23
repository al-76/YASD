//
//  StorageService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 29.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import RxSwift

class StorageService<T: Encodable & Decodable & Equatable> {
    private let id: String
    private let storage: Storage
    
    private lazy var data: [T] = {
        return self.storage.get(id: id, defaultObject: [T]())
    }()
    
    init(id: String, storage: Storage) {
        self.id = id
        self.storage = storage
    }
    
    func get(with word: T, where filterFunc: @escaping (T, T) -> Bool) -> Observable<Result<[T]>> {
        return Observable.create { [weak self] observer in
            if let data = self?.data {
                let filtered = data.filter { filterFunc($0, word) }
                observer.onNext(.success(filtered))
            } else {
                observer.onNext(.success([]))
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func add(_ word: T) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            do {
                if self?.data.firstIndex(where: { $0 == word }) == nil { // yes yes, I know about ordered set
                    self?.data.append(word)
                    try self?.saveData()
                }
                observer.onNext(())
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create {}
        }
    }
    
    func remove(_ word: T) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            do {
                if let index = self?.data.firstIndex(where: { $0 == word }) {
                    self?.data.remove(at: index)
                    try self?.saveData()
                }
                observer.onNext(())
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create {}
        }
    }
    
    private func saveData() throws {
        try storage.save(id: id, object: data)
    }
}
