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
    private let lexinParameters: ParametersStorage
    private var languageItems: [SettingsItem]
    
    struct Input {
        let selectedLanguage: Driver<String>
    }
    
    struct Output {
        let languages: Driver<[SettingsItem]>
    }
    
    init(lexinParameters: ParametersStorage) {
        self.lexinParameters = lexinParameters
        self.languageItems = SettingsLanguageViewModel.createSettingsLanguageItems(lexinParameters.getLanguage())
    }
    
    func transform(from input: Input) -> Output {
        let selectedLanguage = input.selectedLanguage.flatMapLatest { [weak self] language -> Driver<[SettingsItem]> in
            guard let self = self else { return Driver.just([]) }
            self.updateParameters(with: language)
            return Driver.just(self.languageItems)
        }
        return Output(languages: selectedLanguage.startWith(self.languageItems))
    }
    
    private func updateParameters(with language: String) {
        if let new = languageItems.firstIndex(where: { $0.language.name == language}) {
            if let old = languageItems.firstIndex(where: { $0.selected }) {
                languageItems[old].selected = false
            }
            let newLanguage = languageItems[new].language
            lexinParameters.setLanguage(newLanguage)
            languageItems[new].selected = true
        }
    }
    
    private static func createSettingsLanguageItems(_ language: Language) -> [SettingsItem] {
        var res = ParametersStorage.supportedLanguages.map {
            SettingsItem(selected: false, language: $0)
        }
        if let selected = res.firstIndex(where: { $0.language == language  }) {
            res[selected].selected = true
        }
        return res
    }
}
