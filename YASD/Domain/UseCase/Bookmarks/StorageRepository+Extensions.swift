//
//  StorageRepository+Extensions.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 17.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

extension StorageRepository where T == FormattedWord {
    func get(with word: String) -> Observable<Bookmarks> {
        return get(where: { $0.header.lowercased().starts(with: word.lowercased()) })
    }

    func getAndIndex(cache: ExternalCacheService) -> Observable<Bookmarks> {
        get(with: "").flatMap { result -> Observable<Bookmarks> in
            switch result {
            case let .success(words):
                return cache.index(data: words)
                    .map { _ in result }
            case let .failure(error):
                return .just(.failure(error))
            }
        }
    }
}
