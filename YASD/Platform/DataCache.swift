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

// TODO: return errors
class DataCache {
    private let name: String
    private var storage: Cache.Storage<String, Data>? = nil
    private let changed = PublishSubject<Bool>()
    
    init(name: String) {
        self.name = name
    }
    
    func save(_ data: Data, forKey key: String) -> Observable<Data> {
        return Observable.create { [weak self] observer in
            if let self = self {
                try? self.getStorage().setObject(data, forKey: key)
                observer.onNext(data)
                self.changed.onNext(true)
            } else {
                observer.onNext(Data())
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func load(_ key: String) -> Observable<Data?> {
        return Observable.create { [weak self] observer in
            if let self = self {
                observer.onNext(try? self.getStorage().object(forKey: key))
            } else {
                observer.onNext(nil)
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
    
    func clear() -> Observable<Bool> {
        return Observable.create { [weak self] observer in
            if let self = self {
                let storage = try? self.getStorage()
                try? storage?.removeAll()
                observer.onNext(true)
                self.changed.onNext(true)
            } else {
                observer.onNext(false)
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
