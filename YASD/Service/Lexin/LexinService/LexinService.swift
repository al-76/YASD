//
//  LexinService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 02.06.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import RxSwift
import Foundation

protocol LexinService {
    func search(_ word: String) -> Observable<LexinWordResult>
    func suggestion(_ word: String) -> Observable<SuggestionResult>
    func language() -> BehaviorSubject<Language>
}
