//
//  LexinWordMapper.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/12/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift

class LexinWordMapper: Mapper {
    typealias Input = LexinWordResult
    typealias Output = Observable<FoundWordResult>
    
    private let formatter: LexinServiceFormatter
    private let bookmarks: AnyStorageRepository<FormattedWord>
    
    init(formatter: LexinServiceFormatter, bookmarks: AnyStorageRepository<FormattedWord>) {
        self.formatter = formatter
        self.bookmarks = bookmarks
    }
    
    public func map(input: Input) -> Output {
        return Observable.just(formatter.format(result: input))
            .flatMap { [weak self] words -> Output in
            guard let self = self else { return Observable.just(.success([])) }
            return self.checkBookmarked(words)
        }
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
