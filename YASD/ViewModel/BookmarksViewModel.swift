////
////  BookmarksViewModel.swift
////  YASD
////
////  Created by Vyacheslav Konopkin on 23.12.2019.
////  Copyright © 2019 yac. All rights reserved.
////
//
//import RxSwift
//import RxCocoa
//
//class BookmarksViewModel: ViewModel {
//    private let bookmarks: StorageService<Bookmark>
//    
//    struct Input {
//        let search: Driver<String>
//        let removeBookmark: Driver<String>
//    }
//    
//    struct Output {
//        let bookmarks: Driver<FormattedWord>
//    }
//    
//    init(bookmarks: StorageService<FormattedWord>) {
//        self.bookmarks = bookmarks
//    }
//    
//    func transform(from input: Input) -> Output {
//        input.search { [weak self] word in return bookmarks.get { }}
//        
//        return Output(bookmarks: Driver.just(FormattedWord(formatted: NSAttributedString(), soundUrl: "")))
//    }
//}
