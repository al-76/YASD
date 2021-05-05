//
//  RemoveSuggestionUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 22.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class RemoveSuggestionUseCase: UseCase {
    typealias Input = String
    typealias Output = StorageServiceResult
    
    private let history: AnyStorageRepository<Suggestion>
    
    init(history: AnyStorageRepository<Suggestion>) {
        self.history = history
    }
    
    func execute(with input: String) -> Observable<StorageServiceResult> {
        return history.remove(input.lowercased())
    }
}
