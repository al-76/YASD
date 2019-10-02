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
    let storage: Cache.Storage<Data>
    
    init(name: String) throws {
        let diskConfig = DiskConfig(name: name)
        let memoryConfig = MemoryConfig(expiry: .date(Date().addingTimeInterval(2 * 60)), countLimit: 10, totalCostLimit: 10)
        self.storage = try Cache.Storage(diskConfig: diskConfig,
                                         memoryConfig: memoryConfig,
                                         transformer: TransformerFactory.forCodable(ofType: Data.self))
    }
    
    func save(key: String, data: Data) -> Observable<Data> {
        return Observable.create { [weak self] observer in
            if let self = self {
                do {
                    try self.storage.setObject(data, forKey: key)
                    observer.onNext(data)
                    observer.onCompleted()
                } catch let error {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }

    func load(key: String) -> Observable<Data?> {
        return Observable.create { [weak self] observer in
            if let self = self {
                do {
                    observer.onNext(try self.storage.object(forKey: key))
                } catch {
                    observer.onNext(nil)
                }
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
