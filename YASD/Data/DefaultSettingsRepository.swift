//
//  DefaultSettingsRepository.swift
//  YASD
//
//  Created by Jobbare on 16.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class DefaultSettingsRepository: SettingsRepository {
    private let storage: Storage
    public let language = PublishSubject<Language>()


    init(storage: Storage) {
        self.storage = storage
    }
    
    func setLanguage(_ name: String) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            if let self = self {
                let language = self.getLanguage(by: name)
                try? self.storage.save(id: "language", object: language)
                self.language.onNext(language)
            }
            observer.onNext(())
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getLanguage() -> Observable<Language> {
        return Observable.create { [weak self] observer in
            if let self = self {
                let language = self.storage.get(id: "language", defaultObject: Language.defaultLanguage)
                observer.onNext(language)
            } else {
                observer.onNext(Language.defaultLanguage)
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func getLanguageList(with name: String) -> Observable<SettingsLanguageItemResult> {
        return getLanguage().map { language in
            return Language.supportedLanguages
                .filter { $0.name.lowercased().starts(with: name.lowercased()) }
                .map {
                SettingsLanguageItem(selected: ($0 == language), language: $0)
            }
        }
        .map {
            .success($0)
        }
    }
    
    func getLanguageBehaviour() -> PublishSubject<Language> {
        return language
    }
    
    private func getLanguage(by name: String) -> Language {
        guard let language = Language.supportedLanguages.first(where: { $0.name == name}) else { return Language.defaultLanguage }
        return language
    }
}
