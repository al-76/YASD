//
//  SuggestionResult+Extensions.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 22.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation

extension SuggestionResult {
    func toItem(removable: Bool) -> SuggestionItemResult {
        switch(self) {
        case let .success(items):
            return SuggestionItemResult.success(items.map { SuggestionItem(suggestion: $0, removable: removable)})
        case let .failure(error):
            return SuggestionItemResult.failure(error)
        }
    }
    
    func reversed() -> SuggestionResult {
        switch(self) {
        case let .success(result):
            return .success(result.reversed())
        default:
            return self
        }
    }
}
