//
//  LexinApi.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift

protocol LexinApi {
    func search(word: String, add: String) -> Observable<LexinServiceResult>
    func suggestion(word: String, add: String) -> Observable<LexinServiceSuggestionResult>
}
