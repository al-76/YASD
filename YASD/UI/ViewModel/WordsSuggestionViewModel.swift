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
    private let getSuggestion: GetSuggestionUseCase
    private let addSuggestion: AddSuggestionUseCase
    private let removeSuggestion: RemoveSuggestionUseCase
    
    struct Input {
        let search: Driver<String>
        let addHistory: Driver<String>
        let removeHistory: Driver<String>
    }
    
    struct Output {
        let suggestions: Driver<SuggestionItemResult>
    }
    
    init(getSuggestion: GetSuggestionUseCase,
         addSuggestion: AddSuggestionUseCase,
         removeSuggestion: RemoveSuggestionUseCase) {
        self.getSuggestion = getSuggestion
        self.addSuggestion = addSuggestion
        self.removeSuggestion = removeSuggestion
    }
    
    func transform(from input: Input) -> Output {
        let found = input.search
            .flatMapLatest { [weak self] word -> Driver<SuggestionItemResult> in
                guard let self = self else { return .just(.success([])) }
                return self.getSuggestion.execute(with: word)
                    .asDriver { .just(.failure($0)) }
            }
        let added = input.addHistory
            .filter { !$0.isEmpty }
            .flatMapLatest { [weak self] word -> Driver<SuggestionItemResult> in
                guard let self = self else { return .just(.success([])) }
                return self.addSuggestion.execute(with: word)
                    .asDriver { .just(.failure($0)) }
            }
        let removed = input.removeHistory
            .filter { !$0.isEmpty }
            .flatMapLatest { [weak self] word -> Driver<StorageServiceResult> in
                guard let self = self else { return .just(.success(false)) }
                return self.removeSuggestion.execute(with: word)
                    .asDriver { .just(.failure($0)) }
            }
            .withLatestFrom(input.search) { ($0, $1) }
            .flatMapLatest { [weak self] _, word -> Driver<SuggestionItemResult> in
                guard let self = self else { return .just(.success([])) }
                return self.getSuggestion.execute(with: word)
                    .asDriver { .just(.failure($0)) }
            }

        return Output(suggestions: Driver.merge(found, added, removed))
    }
}
