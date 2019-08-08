//
//  SettingsLanguageTableViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 03/07/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import RxCocoa

class SettingsLanguageViewModel: ViewModel {
    private let lexinParameters: LexinServiceParameters
    private var languageItems: [SettingsItem]
    
    struct Input {
        let selectedLanguage: Driver<String>
    }
    
    struct Output {
        let languages: Driver<[SettingsItem]>
    }

    struct SettingsItem {
        var selected: Bool
        let language: LexinServiceParameters.Language
    }
    
    init(lexinParameters: LexinServiceParameters) {
        self.lexinParameters = lexinParameters
        self.languageItems = SettingsLanguageViewModel.createSettingsLanguageItems(language: lexinParameters.language.value)
    }
    
    func transform(input: Input) -> Output {
        let selectedLanguage = input.selectedLanguage.flatMapLatest { [weak self] selected -> Driver<[SettingsItem]> in
            self?.updateParameters(language: selected)
            return Driver.just(self?.languageItems ?? [])
        }
        return Output(languages: selectedLanguage.startWith(self.languageItems))
    }
    
    private func updateParameters(language: String) {
        if let new = languageItems.firstIndex(where: { $0.language.name == language}) {
            if let old = languageItems.firstIndex(where: { $0.selected }) {
                languageItems[old].selected = false
            }
            lexinParameters.language.accept(languageItems[new].language)
            languageItems[new].selected = true
        }
    }
    
    fileprivate static func createSettingsLanguageItems(language: LexinServiceParameters.Language) -> [SettingsItem] {
        var res = LexinServiceParameters.supportedLanguages.map {
            SettingsItem(selected: false, language: $0)
        }
        if let selected = res.firstIndex(where: { $0.language == language  }) {
            res[selected].selected = true
        }
        return res
    }
}
