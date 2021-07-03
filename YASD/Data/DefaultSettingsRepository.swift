//
//  DefaultSettingsRepository.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 16.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class DefaultSettingsRepository: SettingsRepository {
    enum DefaultSettingsRepositoryError: Error {
        case noContext
    }
    
    private let storage: Storage
    public let language = PublishSubject<Language>()

    init(storage: Storage) {
        self.storage = storage
    }
    
    func setLanguage(_ name: String) -> Observable<SettingsRepositoryResult> {
        return Observable.create { [weak self] observer in
            if let self = self {
                do {
                    let language = self.getLanguage(by: name)
                    try self.storage.save(id: "language", object: language)
                    self.language.onNext(language)
                    observer.onNext(.success(true))
                } catch let error {
                    observer.onNext(.failure(error))
                }
            } else {
                observer.onNext(.failure(DefaultSettingsRepositoryError.noContext))
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getLanguage() -> Observable<SettingsRepositoryLanguageResult> {
        return Observable.create { [weak self] observer in
            if let self = self {
                let language = self.storage.get(id: "language", defaultObject: Language.defaultLanguage)
                observer.onNext(.success(language))
            } else {
                observer.onNext(.failure(DefaultSettingsRepositoryError.noContext))
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
    
    func getLanguageList(with name: String) -> Observable<SettingsRepositoryItemResult> {
        return getLanguage().map { result -> SettingsRepositoryItemResult in
            switch(result) {
            case let .success(language):
                return .success(Language.supportedLanguages
                    .filter { $0.name.lowercased().starts(with: name.lowercased()) }
                    .map {
                        SettingsLanguageItem(selected: ($0 == language),
                                         language: $0)
                    })
            case let .failure(error):
                return .failure(error)
            }
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
