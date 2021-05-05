//
//  SettingsRepository.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 16.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

protocol SettingsRepository {
    func setLanguage(_ language: String) -> Observable<Void>
    func getLanguage() -> Observable<Language>
    func getLanguageList(with name: String) -> Observable<SettingsLanguageItemResult>
    func getLanguageBehaviour() -> PublishSubject<Language>
}
