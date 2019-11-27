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
        let suggestions: Driver<SuggestionResult>
    }
    
    init(lexin: LexinService) {
        self.lexin = lexin
    }
    
    func transform(from input: Input) -> Output {
        return Output(suggestions: input.searchBar.flatMapLatest { [weak self] word in
            guard let self = self else { return Driver.just(.success([])) }
            return self.suggestion(word)
        })
    }
    
    private func suggestion(_ word: String) -> Driver<SuggestionResult> {
        return lexin.suggestion(word).asDriver { Driver.just(.failure($0)) }
    }
}
