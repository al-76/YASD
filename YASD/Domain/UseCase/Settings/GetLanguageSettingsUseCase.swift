//
//  GetLanguageSettingsUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 23.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class GetLanguageSettingsUseCase: UseCase {
    typealias Input = Void
    typealias Output = String
    
    private let repository: SettingsRepository
    
    init(repository: SettingsRepository) {
        self.repository = repository
    }
    
    func execute(with input: Void) -> Observable<String> {
        return Observable.merge(repository.getLanguage(), repository.getLanguageBehaviour()).map { $0.name }
    }
}
