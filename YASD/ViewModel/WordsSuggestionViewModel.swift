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
    private let history: StorageService<Suggestion>

    struct Input {
        let search: Driver<String>
        let addHistory: Driver<String>
        let removeHistory: Driver<String>
    }

    struct Output {
        let suggestions: Driver<SuggestionItemResult>
    }
    
    init(lexin: LexinService, history: StorageService<Suggestion>) {
        self.lexin = lexin
        self.history = history
    }
    
    func transform(from input: Input) -> Output {
        let suggestionResult = input.search
            .flatMapLatest { [weak self] word -> Driver<SuggestionItemResult> in
            guard let self = self else { return Driver.just(.success([])) }
            return self.getSuggestionAndHistory(word.lowercased())
        }
        let updatedHistoryResult = input.addHistory
            .filter { !$0.isEmpty }
            .flatMapLatest { [weak self] word -> Driver<SuggestionItemResult> in
            guard let self = self else { return Driver.just(.success([])) }
            return self.updateHistory(word.lowercased())
        }
        let removedHistoryResult = input.removeHistory
            .filter { !$0.isEmpty }
            .withLatestFrom(input.search) { ($0, $1) }
            .flatMapLatest { [weak self] word, currentWord -> Driver<SuggestionItemResult> in
            guard let self = self else { return Driver.just(.success([])) }
            return self.removeHistory(word, with: currentWord)
        }
        return Output(suggestions: Driver.merge(suggestionResult, updatedHistoryResult, removedHistoryResult))
    }
    
    private func getSuggestionAndHistory(_ word: String) -> Driver<SuggestionItemResult> {
        return Observable.combineLatest(lexin.suggestion(word),
                                        history.get(where: { $0?.starts(with: word) ?? false }),
                                    resultSelector: { suggestion, history in
                                        let filtered = suggestion.filter(history).toItem(removable: false)
                                        let merged = filtered.merge(history.toItem(removable: true))
                                        return merged
            }).asDriver { Driver.just(.failure($0)) }
    }
    
    private func updateHistory(_ word: String) -> Driver<SuggestionItemResult> {
        return historyAction(history.add(word), with: word)
    }
    
    private func removeHistory(_ word: String, with current: String) -> Driver<SuggestionItemResult> {
        return historyAction(history.remove(word), with: current)
    }
    
    private func historyAction(_ action: Observable<StorageServiceResult>, with word: String) -> Driver<SuggestionItemResult> {
        return action.asDriver { Driver.just(.failure($0)) }
            .flatMap { [weak self] _ -> Driver<SuggestionItemResult> in
                guard let self = self else { return Driver.just(.success([])) }
                return self.getSuggestionAndHistory(word)
        }
    }
}

private extension SuggestionResult {
    func toItem(removable: Bool) -> SuggestionItemResult {
        switch(self) {
        case let .success(items):
            return SuggestionItemResult.success(items.map { SuggestionItem(suggestion: $0, removable: removable)})
        case let .failure(error):
            return SuggestionItemResult.failure(error)
        }
    }
}

private extension SuggestionItemResult {
    func merge(_ result: SuggestionItemResult) -> SuggestionItemResult {
        switch((self, result)) {
        case let (.success(result1), .success(result2)):
            return .success(result1 + result2)
        default:
            return self
        }
    }
}
