//
//  Suggestion.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation

struct SuggestionItem {
    let suggestion: Suggestion
    let removable: Bool
}
typealias SuggestionItemResult = Result<[SuggestionItem]>
typealias Suggestion = String?
typealias SuggestionResult = Result<[Suggestion]>

extension SuggestionResult {
    func merge(_ result: SuggestionResult) -> SuggestionResult {
        switch((self, result)) {
        case let (.success(result1), .success(result2)):
            return .success(result1 + result2)
        default:
            return self
        }
    }
    
    func filter(_ result: SuggestionResult) -> SuggestionResult {
        switch((self, result)) {
        case let (.success(result1), .success(result2)):
            let res: SuggestionResult = .success(result1.filter { !result2.contains($0) }.compactMap { $0 })
            return res
        default:
            return self
        }
    }
}

