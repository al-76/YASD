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

class PlayerManagerImpl: PlayerManager {
    private let player: Player
    private let cache: CacheService
    private let network: Network
    
    init(player: Player, cache: CacheService, network: Network) {
        self.player = player
        self.cache = cache
        self.network = network
    }
    
    func playSound(with url: String) -> Observable<PlayerServiceResult> {
        let action: CachableAction = { [weak self] in
            guard let self = self else { return Observable.just(.success(Data())) }
            return self.network.getRequest(with: url)
        }
        return cache.run(action, forKey: url)
            .map { [weak self] result in
                guard let self = self else { return .success(false) }
                return result.flatMap { self.playAction($0) }
        }
    }
    
    private func playAction(_ data: Data) -> PlayerServiceResult {
        do {
            try self.player.play(with: data)
        } catch let error {
            return .failure(error)
        }
        return .success(true)
    }
}
