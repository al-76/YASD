//
//  WordService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 28.06.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import RxSwift
import Foundation

protocol WordsService {
    func search(_ word: String) -> Observable<LexinWordResult>
}
