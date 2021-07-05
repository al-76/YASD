//
//  SuggestionItemResult+Extensions.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 22.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation

extension SuggestionItemResult {
    func merge(_ result: SuggestionItemResult) -> SuggestionItemResult {
        switch (self, result) {
        case let (.success(result1), .success(result2)):
            return .success(result1 + result2)
        default:
            return self
        }
    }
}
