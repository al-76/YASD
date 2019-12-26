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
        let search: Driver<String>
        let select: Driver<String>
    }
    
    struct Output {
        let languages: Driver<[SettingsItem]>
    }
    
    init(lexinParameters: ParametersStorage) {
        self.lexinParameters = lexinParameters
        self.languageItems = SettingsLanguageViewModel.createSettingsLanguageItems(lexinParameters.getLanguage())
    }
    
    func transform(from input: Input) -> Output {
        let searched = input.search
            .flatMapLatest { [weak self] language -> Driver<[SettingsItem]> in
                guard let self = self else { return Driver.just([]) }
                return Driver.just(self.filterLanguage(with: language))
        }
        let selected = input.select
            .withLatestFrom(input.search) { [weak self] selectedLanguage, searchLanguage -> [SettingsItem] in
                guard let self = self else { return [] }
                self.updateParameters(with: selectedLanguage)
                return self.filterLanguage(with: searchLanguage)
        }
        return Output(languages: Driver.merge(selected.startWith(self.languageItems), searched))
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
    
    private func filterLanguage(with language: String) -> [SettingsItem] {
        return languageItems
            .filter { $0.language.name.lowercased().starts(with: language.lowercased()) }
            .compactMap { $0 }
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
