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

class DataCache {
    private let name: String
    private var storage: Cache.Storage<Data>? = nil
    
    init(name: String) {
        self.name = name
    }
    
    func save(_ data: Data, forKey key: String) -> Observable<Data> {
        return Observable.create { [weak self] observer in
            do {
                if let self = self {
                    try self.getStorage().setObject(data, forKey: key)
                    observer.onNext(data)
                } else {
                    observer.onNext(Data())
                }
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func load(_ key: String) -> Observable<Data?> {
        return Observable.create { [weak self] observer in
            do {
                if let self = self {
                    observer.onNext(try self.getStorage().object(forKey: key))
                } else {
                    observer.onNext(nil)
                }
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    private func getStorage() throws -> Cache.Storage<Data> {
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
