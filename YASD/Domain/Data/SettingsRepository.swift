//
//  SettingsRepository.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 16.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

typealias SettingsRepositoryResult = Result<Bool>
typealias SettingsRepositoryLanguageResult = Result<Language>
typealias SettingsRepositoryItemResult = Result<[SettingsLanguageItem]>

protocol SettingsRepository {
    func setLanguage(_ language: String) -> Observable<SettingsRepositoryResult>
    func getLanguage() -> Observable<SettingsRepositoryLanguageResult>
    func getLanguageList(with name: String) -> Observable<SettingsRepositoryItemResult>
    func getLanguageBehaviour() -> PublishSubject<Language>
}
