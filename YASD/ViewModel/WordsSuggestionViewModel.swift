//
//  WordsSuggestionViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 10.10.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import RxCocoa

class WordsSuggestionViewModel: ViewModel {
    private let lexin: LexinService

    struct Input {
        let searchBar: Driver<String>
    }

    struct Output {
        let suggestions: Driver<LexinParserSuggestionResult>
    }
    
    init(lexin: LexinService) {
        self.lexin = lexin
    }
    
    func transform(input: Input) -> Output {
        return Output(suggestions: input.searchBar.flatMapLatest { [weak self] word in
            guard let self = self else { return Driver.just(.success([])) }
            return self.suggestion(word: word)
        })
    }
    
    private func suggestion(word: String) -> Driver<LexinParserSuggestionResult> {
        return lexin.suggestion(word: word).asDriver { Driver.just(.failure($0)) }
    }
}
