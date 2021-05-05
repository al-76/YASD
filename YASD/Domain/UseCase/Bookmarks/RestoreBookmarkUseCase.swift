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
    
    private let cache: ExternalCacheService

    init(cache: ExternalCacheService) {
        self.cache = cache
    }
    
    func execute(with input: String) -> Observable<String> {
        return .just(cache.getTitle(from: input))
    }
}
