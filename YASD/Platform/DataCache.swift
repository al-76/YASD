//
//  DataCache.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import Foundation
import Cache

typealias DataCacheResult = Result<Data>
typealias DataCacheOptResult = Result<Data?>
typealias DataCacheBoolResult = Result<Bool>

class DataCache {
    enum DataCacheError: Error {
        case noContext
    }
    
    private let name: String
    private var storage: Cache.Storage<String, Data>? = nil
    private let changed = PublishSubject<Bool>()
    
    init(name: String) {
        self.name = name
    }
    
    func save(_ data: Data, forKey key: String) -> Observable<DataCacheResult> {
        return Observable.create { [weak self] observer in
            if let self = self {
                do {
                    try self.getStorage().setObject(data, forKey: key)
                    observer.onNext(.success(data))
                    self.changed.onNext(true)
                } catch let error {
                    observer.onNext(.failure(error))
                }
            } else {
                observer.onNext(.failure(DataCacheError.noContext))
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func load(_ key: String) -> Observable<DataCacheOptResult> {
        return Observable.create { [weak self] observer in
            if let self = self {
                let data = try? self.getStorage().object(forKey: key)
                observer.onNext(.success(data))
            } else {
                observer.onNext(.failure(DataCacheError.noContext))
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getSize() -> Observable<Int> {
        let size = Observable<Int>.create { [weak self] observer in
            observer.onNext(self?.getStorageSize() ?? 0)
            observer.onCompleted()
            return Disposables.create {}
        }
        let changedSize = changed.flatMap { _ in size }
        return Observable.merge(changedSize, size)
    }
    
    func clear() -> Observable<DataCacheBoolResult> {
        return Observable.create { [weak self] observer in
            if let self = self {
                do {
                    let storage = try self.getStorage()
                    try storage.removeAll()
                    observer.onNext(.success(true))
                    self.changed.onNext(true)
                } catch let error {
                    observer.onNext(.failure(error))
                }
            } else {
                observer.onNext(.failure(DataCacheError.noContext))
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    private func getStorageSize() -> Int {
        let storage = try? getStorage()
        return storage?.totalDiskStorageSize ?? 0
    }
    
    private func getStorage() throws -> Cache.Storage<String, Data> {
        if storage == nil {
            let diskConfig = DiskConfig(name: name)
            let memoryConfig = MemoryConfig(expiry: .date(Date().addingTimeInterval(10 * 60)),
                                            countLimit: 10,
                                            totalCostLimit: 10)
            return try Cache.Storage(diskConfig: diskConfig,
                memoryConfig: memoryConfig,
                transformer: TransformerFactory.forCodable(ofType: Data.self))
        }
        return storage!
    }
}
