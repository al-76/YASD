//
//  SettingsLanguageItem+Extensions.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 27.12.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation

extension SettingsLanguageItem: Equatable {
    static public func == (lhs: SettingsLanguageItem, rhs: SettingsLanguageItem) -> Bool {
        return lhs.selected == rhs.selected && lhs.language == rhs.language
    }
}
