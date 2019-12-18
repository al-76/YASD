//
//  SuggestionItem+Extensions.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 13.12.2019.
//  Copyright © 2019 yac. All rights reserved.
//

@testable import YASD

extension SuggestionItem: Equatable {
    static public func == (lhs: SuggestionItem, rhs: SuggestionItem) -> Bool {
        return lhs.suggestion == rhs.suggestion && lhs.removable == rhs.removable
    }
}
