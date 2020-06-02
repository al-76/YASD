//
//  LexinServiceFormatter.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 02.06.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import Foundation

protocol LexinServiceFormatter {
    func format(result: LexinWordResult) -> FormattedWordResult
}
