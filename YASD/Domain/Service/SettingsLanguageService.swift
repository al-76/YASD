//
//  SettingsLanguageService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 23.07.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import Foundation
import RxSwift

typealias SettingsLanguageResult = Result<Bool>

protocol SettingsLanguageService {
    func update(with language: String) -> Observable<SettingsLanguageResult>
    func get(with language: String) -> Observable<SettingsLanguageItemResult>
}
