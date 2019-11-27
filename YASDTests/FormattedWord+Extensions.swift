//
//  FormattedWord+Extensions.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 20/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//

@testable import YASD

extension FormattedWord: Equatable {
    static public func == (lhs: FormattedWord, rhs: FormattedWord) -> Bool {
        return lhs.formatted == rhs.formatted && lhs.soundUrl == rhs.soundUrl
    }
}
