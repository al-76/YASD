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
    private var data: [String] = [String]()
    
    func get(with word: String) -> Observable<SuggestionResult> {
        return Observable.create { [weak self] observer in
            if let data = self?.data {
                observer.onNext(SuggestionResult.success(data.filter { $0.starts(with: word) }))
            } else {
                observer.onNext(SuggestionResult.success([]))
            }
            observer.onCompleted()
            
            return Disposables.create {}
        }
    }
    
    func add(_ word: String) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            if !word.isEmpty &&
                self?.data.firstIndex(of: word) == nil { // yes yes, I know about ordered set
                self?.data.append(word)
            }
            
            observer.onNext(Void())
            observer.onCompleted()
            
            return Disposables.create {}
        }
    }
    
    func remove(_ word: String) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            if var data = self?.data, let index = data.firstIndex(of: word) {
                data.remove(at: index)
            }
            
            observer.onNext(Void())
            observer.onCompleted()
            
            return Disposables.create {}
        }
    }
}
