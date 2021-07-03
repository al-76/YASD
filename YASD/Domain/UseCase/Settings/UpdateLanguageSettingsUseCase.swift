//
//  UpdateLanguageSettingsUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 23.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class UpdateLanguageSettingsUseCase: UseCase {
    typealias Input = String
    typealias Output = SettingsRepositoryResult
    
    private let repository: SettingsRepository
    
    init(repository: SettingsRepository) {
        self.repository = repository
    }
    
    func execute(with input: String) -> Observable<SettingsRepositoryResult> {
        return repository.setLanguage(input)
    }
}
