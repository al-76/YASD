//
//  ClearHistoryUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class ClearHistoryUseCase: UseCase {
    typealias Input = Void
    typealias Output = StorageServiceResult
    
    private let history: AnyStorageRepository<Suggestion>
    
    init(history: AnyStorageRepository<Suggestion>) {
        self.history = history
    }
        
    func execute(with input: Void) -> Observable<StorageServiceResult> {
        return history.removeAll()
    }
}
