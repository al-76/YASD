//
//  Spotlight.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 09.05.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import CoreSpotlight
import Foundation
import MobileCoreServices
import RxSwift

class Spotlight: ExternalCacheService {
    func index(data: [FormattedWord]) -> Observable<ExternalCacheServiceResult> {
        return Observable.create { observer in
            var items = [CSSearchableItem]()

            for item in data {
                let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
                attributeSet.title = item.header
                attributeSet.contentDescription = item.definition
                items.append(CSSearchableItem(uniqueIdentifier: item.header + "&" + item.definition,
                                              domainIdentifier: nil,
                                              attributeSet: attributeSet))
            }

            CSSearchableIndex.default().deleteAllSearchableItems { error in
                if let e = error {
                    observer.onNext(.failure(e))
                    observer.onCompleted()
                    return
                }
                CSSearchableIndex.default().indexSearchableItems(items) { error in
                    if let e = error {
                        observer.onNext(.failure(e))
                    } else {
                        observer.onNext(.success(()))
                    }
                    observer.onCompleted()
                }
            }

            return Disposables.create()
        }
    }

    func getTitle(from id: String) -> String {
        if let index = id.firstIndex(of: "&") {
            return String(id[..<index])
        }
        return ""
    }
}
