//
//  DefaultPlayer.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 03.07.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import AVFoundation
import Foundation

class DefaultPlayer: Player {
    var player: AVAudioPlayer?

    func play(with data: Data) throws {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        player = try AVAudioPlayer(data: data)
        player?.prepareToPlay()
        player?.play()
    }
}
