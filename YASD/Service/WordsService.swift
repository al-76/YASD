//
//  WordsService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/12/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift

class WordsService {
    private let lexin: LexinService
    private let formatter: LexinServiceFormatter
    private let bookmarks: StorageService<FormattedWord>
    
    init(lexin: LexinService, formatter: LexinServiceFormatter, bookmarks: StorageService<FormattedWord>) {
        self.lexin = lexin
        self.formatter = formatter
        self.bookmarks = bookmarks
    }
    
    public func search(_ word: String) -> Observable<FoundWordResult> {
        return searchFormatted(word).flatMap { [weak self] words -> Observable<FoundWordResult> in
            guard let self = self else { return Observable.just(.success([])) }
            return self.checkBookmarked(words)
        }
    }
    
    public func language() -> BehaviorSubject<Language> {
        return lexin.language()
    }
    
    private func searchFormatted(_ word: String) -> Observable<FormattedWordResult> {
        return lexin.search(word)
            .map { [weak self] result in
                guard let self = self else { return .success([]) }
                return self.formatter.format(result: result) }
    }
    
    private func checkBookmarked(_ words: FormattedWordResult) -> Observable<FoundWordResult> {
        switch words {
        case let .success(res):
            return Observable.from(res.map { bookmarks.contains($0) }).merge().toArray()
                .map { bookmarked in
                    return zip(res, bookmarked)
                        .map { FoundWord(word: $0, bookmarked: $1.getOrDefault(false)) }
            }
            .map { .success($0) }
            .asObservable()
        case let .failure(error):
            return Observable.just(.failure(error))
        }
    }
}
