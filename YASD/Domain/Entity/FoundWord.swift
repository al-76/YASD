//
//  FoundWord.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 25.12.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation

struct FoundWord {
    let word: FormattedWord
    let bookmarked: Bool
}

typealias FoundWordResult = Result<[FoundWord]>
