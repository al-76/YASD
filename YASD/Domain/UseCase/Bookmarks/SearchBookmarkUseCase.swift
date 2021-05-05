//
//  SearchBookmarksUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 17.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class SearchBookmarkUseCase: UseCase {
    typealias Input = String
    typealias Output = Bookmarks
    
    private let bookmarks: AnyStorageRepository<FormattedWord>
    
    init(bookmarks: AnyStorageRepository<FormattedWord>) {
        self.bookmarks = bookmarks
    }
    
    func execute(with input: String) -> Observable<Bookmarks> {
        return bookmarks.get(with: input)
    }
}
