//
//  ExternalIndexer.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26.10.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import Foundation
import RxSwift

typealias ExternalIndexerResult = Result<Void>

protocol ExternalIndexer {
    func index(data: [FormattedWord]) -> Observable<ExternalIndexerResult>
    func getTitle(from id: String) -> String
}
