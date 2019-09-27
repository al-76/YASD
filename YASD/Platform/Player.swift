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
    
    func play(url: URL) throws {
        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        player?.prepareToPlay()
        player?.play()
    }
}
