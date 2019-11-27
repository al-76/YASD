//
//  FormattedWord.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation

struct FormattedWord {
    let formatted: NSAttributedString
    let soundUrl: String?
}

typealias FormattedWordResult = Result<[FormattedWord]>
