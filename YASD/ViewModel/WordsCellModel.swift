//
//  WordsCellModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 23/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import RxCocoa

class WordsCellModel: ViewModel {
    private let player: PlayerService
    
    struct Input {
        let url: Driver<String>
    }
    
    struct Output {
        let played: Driver<PlayerServiceResult>
    }
    
    init(player: PlayerService) {
        self.player = player
    }
    
    func transform(input: Input) -> Output {
        let played = input
            .url
            .flatMapLatest { [weak self] url -> Driver<PlayerServiceResult> in
                if let player = self?.player {
                    return player.playSound(stringUrl: url)
                        .asDriver { Driver.just(.failure($0)) }
                }
                return Driver.just(.success(false))
        }
        return Output(played: played)
    }
}
