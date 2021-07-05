//
//  PlayerManagerI.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 03.06.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import Foundation
import RxSwift

typealias PlayerManagerResult = Result<Bool>

protocol PlayerManager {
    func playSound(with url: String) -> Observable<PlayerManagerResult>
}
