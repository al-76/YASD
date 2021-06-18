//
//  RemoveBookmarkByIndexUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 17.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class RemoveBookmarkByIndexUseCase: UseCase {
    typealias Input = Int
    typealias Output = StorageServiceResult
    
    private let bookmarks: AnyStorageRepository<FormattedWord>
    
    init(bookmarks: AnyStorageRepository<FormattedWord>) {
        self.bookmarks = bookmarks
    }
    
    func execute(with input: Int) -> Observable<StorageServiceResult> {
        return bookmarks.remove(at: input)
    }
}
