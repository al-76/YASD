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
    private let history: HistoryService

    struct Input {
        let searchText: Driver<String>
        let forHistory: Driver<String>
    }

    struct Output {
        let suggestions: Driver<SuggestionItemResult>
//        let history: Driver<SuggestionItemResult>
    }
    
    init(lexin: LexinService, history: HistoryService) {
        self.lexin = lexin
        self.history = history
    }
    
    func transform(from input: Input) -> Output {
        let searchText = input.searchText.map { $0.lowercased() }
        let suggestionResult = searchText.flatMapLatest { [weak self] word -> Driver<SuggestionItemResult> in
            guard let self = self else { return Driver.just(.success([])) }
            return self.getSuggestion(word).map { $0.toItem(removable: false) }
        }
        
        let currentHistoryResult = searchText.flatMapLatest { [weak self] word -> Driver<SuggestionResult> in
            guard let self = self else { return Driver.just(.success([])) }
            return self.getHistory(word)
        }
        let updatedHistoryResult = input.forHistory.flatMapLatest { [weak self] word -> Driver<SuggestionResult> in
            guard let self = self else { return Driver.just(.success([])) }
            return self.updateHistory(word)
        }
        let historyResult = Driver.merge(currentHistoryResult, updatedHistoryResult).map { $0.toItem(removable: true) }
        
        return Output(suggestions: suggestionResult)//Driver.merge(suggestionResult, historyResult))//, history: Driver.merge(historyResult, updatedHistoryResult).filter { $0 != .success([]) })
    }
    
    private func getSuggestion(_ word: String) -> Driver<SuggestionResult> {
        return Driver.combineLatest(lexin.suggestion(word).asDriver { Driver.just(.failure($0)) },
                                    getHistory(word),
                                    resultSelector: { $0.filter($1)})
    }
    
    private func getHistory(_ word: String) -> Driver<SuggestionResult> {
        return history.get(with: word).asDriver { Driver.just(.failure($0)) }
    }
    
    private func updateHistory(_ word: String) -> Driver<SuggestionResult> {
        return history.add(word)
            .asDriver(onErrorJustReturn: Void())
            .flatMap { [weak self] _ -> Driver<SuggestionResult> in
                guard let self = self else { return Driver.just(.success([])) }
                return self.getHistory(word)
        }
    }
}

private extension SuggestionResult {
    func toItem(removable: Bool) -> SuggestionItemResult {
        switch(self) {
        case let .success(items):
            return SuggestionItemResult.success(items.map { (items: $0, removable: removable)})
        case let .failure(error):
            return SuggestionItemResult.failure(error)
        }
    }
}
