//
//  RestoreBookmarksUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 17.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class RestoreBookmarkUseCase: UseCase {
    typealias Input = String
    typealias Output = String

    private let indexer: ExternalIndexer

    init(indexer: ExternalIndexer) {
        self.indexer = indexer
    }

    func execute(with input: String) -> Observable<String> {
        return .just(indexer.getTitle(from: input))
    }
}
