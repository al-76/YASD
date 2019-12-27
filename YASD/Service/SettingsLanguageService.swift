//
//  SettingsLanguageService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27.12.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift

typealias SettingsLanguageResult = Result<Bool>

class SettingsLanguageService {
    private let parameters: ParametersStorage
    private lazy var languageItems: [SettingsLanguageItem] = {
        SettingsLanguageService.createSettingsLanguageItems(parameters.getLanguage())
    }()
    
    init(parameters: ParametersStorage) {
        self.parameters = parameters
    }
    
    func update(with language: String) -> Observable<SettingsLanguageResult> {
        return Observable.create { [weak self] observer in
            if let self = self {
                self.updateParamatersAction(with: language)
                observer.onNext(.success(true))
            } else {
                observer.onNext(.success(false))
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func get(with language: String) -> Observable<SettingsLanguageItemResult> {
        return Observable.create { [weak self] observer in
            if let self = self {
                observer.onNext(.success(self.getItemsAction(with: language)))
            } else {
                observer.onNext(.success([]))
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
        
    private func getItemsAction(with language: String) -> [SettingsLanguageItem] {
        return languageItems
            .filter { $0.language.name.lowercased().starts(with: language.lowercased()) }
            .compactMap { $0 }
    }
    
    private func updateParamatersAction(with language: String) {
        if let new = languageItems.firstIndex(where: { $0.language.name == language}) {
            if let old = languageItems.firstIndex(where: { $0.selected }) {
                languageItems[old].selected = false
            }
            let newLanguage = languageItems[new].language
            parameters.setLanguage(newLanguage)
            languageItems[new].selected = true
        }
    }
    
    private static func createSettingsLanguageItems(_ language: Language) -> [SettingsLanguageItem] {
        var res = ParametersStorage.supportedLanguages.map {
            SettingsLanguageItem(selected: false, language: $0)
        }
        if let selected = res.firstIndex(where: { $0.language == language  }) {
            res[selected].selected = true
        }
        return res
    }
}
