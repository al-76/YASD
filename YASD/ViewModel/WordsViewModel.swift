//
//  WordsTableViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 14/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import RxCocoa

class WordsViewModel: ViewModel {
    private let lexin: LexinService
    private let player: PlayerService
    private var lastWord = ""
    
    struct Input {
        let searchBar: Driver<String>
    }

    struct Output {
        let foundWords: Driver<LexinServiceResultFormatted>
    }
    
    init(lexin: LexinService, player: PlayerService) {
        self.lexin = lexin
        self.player = player
    }
    
    func transform(input: Input) -> Output {
        lexin.parameters.load()
        // Search a word
        let searchedBar = input.searchBar
            .flatMapLatest { [weak self] word -> Driver<LexinServiceResult> in
                self?.lastWord = word
                return self?.searchWord(word: word) ?? Driver.just(.success([]))
        }
        let updateSearch = lexin.parameters.language.asDriver()
            .flatMapLatest { [weak self] _ -> Driver<LexinServiceResult> in
            if let model = self,
                let word = self?.lastWord {
                return model.searchWord(word: word)
            }
            return Driver.just(.success([]))
        }
        let searched = Driver.merge(searchedBar, updateSearch)
        let formatted = searched.flatMap { [weak self] in
            Driver.just(self?.lexin.formatter.format(result: $0) ?? .success([]))
        }
        return Output(foundWords: formatted)
    }
    
    func newCell() -> WordsCellModel {
        return WordsCellModel(player: player)
    }
    
    private func searchWord(word: String) -> Driver<LexinServiceResult> {
        return lexin.search(word: word).asDriver { Driver.just(.failure($0)) }
    }
}
