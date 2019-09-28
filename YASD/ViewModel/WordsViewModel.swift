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
                guard let self = self else { return Driver.just(.success([])) }
                self.lastWord = word
                return self.searchWord(word: word)
        }
        let updateSearch = lexin.parameters.language.asDriver()
            .flatMapLatest { [weak self] _ -> Driver<LexinServiceResult> in
                guard let self = self else { return Driver.just(.success([])) }
                return self.searchWord(word: self.lastWord)
        }
        let searched = Driver.merge(searchedBar, updateSearch)
        let formatted = searched.flatMap { [weak self] word -> Driver<LexinServiceResultFormatted> in
            guard let self = self else { return Driver.just(.success([])) }
            return Driver.just(self.lexin.formatter.format(result: word))
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
