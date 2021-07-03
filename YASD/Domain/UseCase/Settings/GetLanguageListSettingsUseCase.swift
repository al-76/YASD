//
//  GetLanguageListSettingsUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 23.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class GetLanguageListSettingsUseCase: UseCase {
    typealias Input = String
    typealias Output = SettingsRepositoryItemResult
    
    private let repository: SettingsRepository

    init(repository: SettingsRepository) {
        self.repository = repository
    }
    
    func execute(with input: String) -> Observable<SettingsRepositoryItemResult> {
        return repository.getLanguageList(with: input)
    }
}
