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
    typealias Output = SettingsRepositoryLanguageResult

    private let repository: SettingsRepository

    init(repository: SettingsRepository) {
        self.repository = repository
    }

    func execute(with _: Void) -> Observable<SettingsRepositoryLanguageResult> {
        return Observable.merge(repository.getLanguage(), repository.getLanguageBehaviour().map { .success($0) })
    }
}
