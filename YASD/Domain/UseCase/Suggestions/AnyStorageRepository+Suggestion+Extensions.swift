//
//  AnyStorageRepository+Suggestion+Extensions.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 22.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

extension AnyStorageRepository where T == Suggestion {
    func getSuggestionAndHistory(suggestions: Observable<SuggestionResult>,
                                 _ word: String) -> Observable<SuggestionItemResult> {
        return Observable.combineLatest(suggestions,
                                        get(where: { $0?.starts(with: word) ?? false }),
                                        resultSelector: { suggestion, history in
                                            let filtered = suggestion.filter(history).toItem(removable: false)
                                            let merged = filtered.merge(history.reversed().toItem(removable: true))
                                            return merged
                                        })
    }
}
