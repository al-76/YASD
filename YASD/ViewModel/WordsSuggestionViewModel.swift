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
    private let suggestion: LexinServiceSuggestion

    struct Input {
        let searchBar: Driver<String>
    }

    struct Output {
        let suggestions: Driver<LexinServiceSuggestionResult>
    }
    
    init(suggestion: LexinServiceSuggestion) {
        self.suggestion = suggestion
    }
    
    func transform(input: Input) -> Output {
        return Output(suggestions: input.searchBar.flatMapLatest { [weak self] word in
            guard let self = self else { return Driver.just(.success([])) }
            return self.suggest(word: word)
        })
    }
    
    private func suggest(word: String) -> Driver<LexinServiceSuggestionResult> {
        return suggestion.suggest(word: word).asDriver { Driver.just(.failure($0)) }
    }
}
