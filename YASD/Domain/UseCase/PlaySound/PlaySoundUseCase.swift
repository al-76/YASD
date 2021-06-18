//
//  PlaySoundUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 17.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class PlaySoundUseCase: UseCase {
    typealias Input = String
    typealias Output = PlayerManagerResult
    
    private let player: PlayerManager
    
    init(player: PlayerManager) {
        self.player = player
    }
    
    func execute(with input: String) -> Observable<PlayerManagerResult> {
        return player.playSound(with: input)
    }
}
