//
//  PlayerService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 13/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import Foundation

typealias PlayerServiceResult = Result<Bool>

class PlayerService {
    private let player: Player
    private let cache: CacheService
    private let network: Network
    
    init(player: Player, cache: CacheService, network: Network) {
        self.player = player
        self.cache = cache
        self.network = network
    }
    
    func playSound(url: String) -> Observable<PlayerServiceResult> {
        let action: CachableAction = { [weak self] in
            guard let self = self else { return Observable.just(Data()) }
            return self.network.getRequest(url: url)
        }
        return cache.runAction(key: url,
                               action: action)
            .map { [weak self] data in
                guard let self = self else { return .success(false) }
                return self.playAction(data: data)
        }
    }
    
    private func playAction(data: Data) -> PlayerServiceResult {
        do {
            try self.player.play(data: data)
        } catch let error {
            return .failure(error)
        }
        return .success(true)
    }
}
