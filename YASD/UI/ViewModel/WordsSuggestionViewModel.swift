//
//  WordsSuggestionViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 10.10.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxCocoa
import RxSwift

class WordsSuggestionViewModel: ViewModel {
    private let getSuggestion: AnyUseCase<String, SuggestionItemResult>
    private let addSuggestion: AnyUseCase<String, SuggestionItemResult>
    private let removeSuggestion: AnyUseCase<String, StorageServiceResult>

    struct Input {
        let search: Driver<String>
        let addHistory: Driver<String>
        let removeHistory: Driver<String>
    }

    struct Output {
        let suggestions: Driver<SuggestionItemResult>
    }

    init(getSuggestion: AnyUseCase<String, SuggestionItemResult>,
         addSuggestion: AnyUseCase<String, SuggestionItemResult>,
         removeSuggestion: AnyUseCase<String, StorageServiceResult>) {
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
