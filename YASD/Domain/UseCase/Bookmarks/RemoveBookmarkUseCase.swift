//
//  RemoveBookmarkUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 22.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class RemoveBookmarkUseCase: UseCase {
    typealias Input = FormattedWord
    typealias Output = StorageServiceResult
    
    private let bookmarks: AnyStorageRepository<FormattedWord>
    
    init(bookmarks: AnyStorageRepository<FormattedWord>) {
        self.bookmarks = bookmarks
    }
    
    func execute(with input: FormattedWord) -> Observable<StorageServiceResult> {
        return bookmarks.remove(input)
    }
}
