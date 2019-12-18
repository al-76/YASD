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
    private let formatter: LexinServiceFormatter
    private let player: PlayerService
    private var lastWord = ""
    
    struct Input {
        let searchBar: Driver<String>
        let playUrl: Driver<String>
    }

    struct Output {
        let foundWords: Driver<FormattedWordResult>
        let played: Driver<PlayerServiceResult>
    }
    
    init(lexin: LexinService, formatter: LexinServiceFormatter, player: PlayerService) {
        self.lexin = lexin
        self.formatter = formatter
        self.player = player
    }
    
    func transform(from input: Input) -> Output {
        let searchedBar = input.searchBar
            .flatMapLatest { [weak self] word -> Driver<FormattedWordResult> in
                guard let self = self else { return Driver.just(.success([])) }
                self.lastWord = word
                return self.searchWord(word)
        }
        let updateSearch = lexin.language()
            .asDriver(onErrorJustReturn: ParametersStorage.defaultLanguage)
            .flatMapLatest { [weak self] _ -> Driver<FormattedWordResult> in
                guard let self = self else { return Driver.just(.success([])) }
                return self.searchWord(self.lastWord)
        }
        let searched = Driver.merge(searchedBar, updateSearch)
        let played = input.playUrl
            .flatMapLatest { [weak self] url -> Driver<PlayerServiceResult> in
                guard let self = self else { return Driver.just(.success(false)) }
                return self.player.playSound(with: url)
                    .asDriver { Driver.just(.failure($0)) }
        }
        return Output(foundWords: searched, played: played)
    }
    
    private func searchWord(_ word: String) -> Driver<FormattedWordResult> {
        return lexin.search(word)
            .map { [weak self] result in
                guard let self = self else { return .success([]) }
                return self.formatter.format(result: result) }
            .asDriver { Driver.just(.failure($0)) }
    }
}
