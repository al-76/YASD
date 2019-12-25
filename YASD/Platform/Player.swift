//
//  Player.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 06/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import AVFoundation

class Player {
    var player: AVAudioPlayer?

    func play(with data: Data) throws {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        player = try AVAudioPlayer(data: data)
        player?.prepareToPlay()
        player?.play()
    }
}
