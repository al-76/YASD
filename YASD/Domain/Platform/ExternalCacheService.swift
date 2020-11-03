//
//  ExternalCacheService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26.10.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import Foundation
import RxSwift

typealias ExternalCacheServiceResult = Result<Void>

protocol ExternalCacheService {
    func index(data: [FormattedWord]) -> Observable<ExternalCacheServiceResult>
    func getTitle(from id: String) -> String
}
