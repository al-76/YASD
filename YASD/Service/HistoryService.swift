//
//  HistoryService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 29.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import RxSwift

class HistoryService {
    private static let STORAGE_ID = "history"
    
    private let storage: Storage
    
    private lazy var data: [String] = {
        return self.storage.get(id: HistoryService.STORAGE_ID, defaultObject: [String]())
    }()
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func get(with word: String) -> Observable<SuggestionResult> {
        return Observable.create { [weak self] observer in
            if let data = self?.data {
                let filtered = data.filter { $0.starts(with: word) }
                observer.onNext(SuggestionResult.success(filtered))
            } else {
                observer.onNext(SuggestionResult.success([]))
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func add(_ word: String) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            do {
                if !word.isEmpty &&
                    self?.data.firstIndex(of: word) == nil { // yes yes, I know about ordered set
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
    
    func remove(at index: Int) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            do {
                self?.data.remove(at: index)
                try self?.saveData()
                observer.onNext(())
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }
            return Disposables.create {}
        }
    }
    
    func remove(_ word: String) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            do {
                if let index = self?.data.firstIndex(of: word) {
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
        try storage.save(id: HistoryService.STORAGE_ID, object: data)
    }
}
