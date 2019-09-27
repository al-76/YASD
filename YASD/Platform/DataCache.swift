//
//  DataCache.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import Foundation

class DataCache {
    private struct Cache {
        let key: String
        let file: URL
    }
    
    private let name: String
    private let files: Files
    private var cache: Cache? = nil
    
    init(name: String, files: Files) {
        self.name = name
        self.files = files
    }
    
    func save(key: String, data: Data) -> Observable<URL> {
        return Observable.create { [weak self] observer in
            if let self = self {
                do {
                    let file = try self.files.createTempFile(name: self.name)
                    try data.write(to: file)
                    self.cache = Cache(key: key, file: file)
                    observer.onNext(file)
                    observer.onCompleted()
                } catch let error {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func load(key: String) -> Observable<URL?> {
        return Observable.create { [weak self] observer in
            if let self = self {
                if let cache = self.cache, cache.key == key {
                    observer.onNext(cache.file)
                } else {
                    observer.onNext(nil)
                }
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
