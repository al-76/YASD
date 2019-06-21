//
//  WordsTableViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 14/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import RxCocoa

class WordsTableViewModel: ViewModel {
    private let lexin: LexinService
    
    struct Input {
        let searchBar: Driver<String>
    }

    struct Output {
        let foundWords: Driver<LexinServiceResultFormatted>
    }
    
    init(lexin: LexinService) {
        self.lexin = lexin
    }
    
    func transform(input: Input) -> Output {
        let searched = input.searchBar
            .flatMapLatest { [weak self] word in
                (self?.lexin.search(word: word).asDriver { error in return Driver.just(.failure(error)) }) ?? Driver.just(.success([]))
        }
        let formated = searched.flatMap { [weak self] in
            Driver.just(self?.lexin.formatter.format(result: $0) ?? .success([]))
        }
        return Output(foundWords: formated)
    }
}
