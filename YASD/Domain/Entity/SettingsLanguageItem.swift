//
//  SettingsLanguageItem.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation

struct SettingsLanguageItem {
    var selected: Bool
    let language: Language
}
typealias SettingsLanguageItemResult = Result<[SettingsLanguageItem]>

extension SettingsLanguageItem: Codable {}
extension SettingsLanguageItem: Equatable {}
