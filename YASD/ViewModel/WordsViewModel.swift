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
        // Search a word
        let searchedBar = input.searchBar
            .flatMapLatest { [weak self] word -> Driver<LexinServiceResultFormatted> in
                guard let self = self else { return Driver.just(.success([])) }
                self.lastWord = word
                return self.searchWord(word: word)
        }
        let updateSearch = lexin.language()
            .asDriver(onErrorJustReturn: LexinServiceParameters.defaultLanguage)
            .flatMapLatest { [weak self] _ -> Driver<LexinServiceResultFormatted> in
                guard let self = self else { return Driver.just(.success([])) }
                return self.searchWord(word: self.lastWord)
        }
        let searched = Driver.merge(searchedBar, updateSearch)
        return Output(foundWords: searched)
    }
    
    func newCell() -> WordsCellModel {
        return WordsCellModel(player: player)
    }
    
    private func searchWord(word: String) -> Driver<LexinServiceResultFormatted> {
        return lexin.search(word: word).asDriver { Driver.just(.failure($0)) }
    }
}
