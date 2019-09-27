//
//  PlayerService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 13/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import Foundation

private struct CachedFile {
    let url: URL
    let file: URL
}

typealias PlayerServiceResult = Result<Bool>

class PlayerService {
    private let player: Player
    private let cache: DataCache
    private let network: Network
    
    init(player: Player, cache: DataCache, network: Network) {
        self.player = player
        self.cache = cache
        self.network = network
    }
    
    func playSound(stringUrl: String) -> Observable<PlayerServiceResult> {
        if let url = URL(string: stringUrl) {
            return playSound(url: url)
        }
        return Observable.just(.success(false))
    }
    
    private func playSound(url: URL) -> Observable<PlayerServiceResult> {
        return cache.load(key: url.absoluteString)
            .flatMap { [weak self] file -> Observable<URL?> in
                guard let self = self, file == nil else { return Observable.just(file) }
                return self.loadFromNetAndUpdateCache(url: url)
            }
            .flatMap { [weak self] file -> Observable<PlayerServiceResult> in
                guard let self = self, let playFile = file else { return Observable.just(.success(false)) }
                return self.playSoundAction(file: playFile)
        }
    }
    
    private func playSoundAction(file: URL) -> Observable<PlayerServiceResult> {
        return Observable.create { [weak self] observer in
            do {
                try self?.player.play(url: file)
                observer.onNext(.success(true))
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
            }

            return Disposables.create {}
        }
    }
    
    private func loadFromNetAndUpdateCache(url: URL) -> Observable<URL?> {
        return network.getRequest(url: url.absoluteString).flatMap { [weak self] data -> Observable<URL?> in
            guard let self = self else { return Observable.just(nil) }
            return self.saveCache(url: url, data: data)
        }
    }
    
    private func saveCache(url: URL, data: Data) -> Observable<URL?> {
        return cache.save(key: url.absoluteString, data: data).map { $0 }
    }
}
