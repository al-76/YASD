//
//  ChangedBookmarksUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 17.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class ChangedBookmarkUseCase: UseCase {
    typealias Input = Void
    typealias Output = Bookmarks
    
    private let bookmarks: AnyStorageRepository<FormattedWord>
    private let cache: ExternalCacheService
    
    init(bookmarks: AnyStorageRepository<FormattedWord>, cache: ExternalCacheService) {
        self.bookmarks = bookmarks
        self.cache = cache
    }
    
    func execute(with input: Void) -> Observable<Bookmarks> {
        return bookmarks.getChangedSubject()
            .filter { $0 }
            .flatMap { [weak self] _ -> Observable<Bookmarks> in
                guard let self = self else { return .just(.success([])) }
                return self.bookmarks.getAndIndex(cache: self.cache)
            }
    }
}
