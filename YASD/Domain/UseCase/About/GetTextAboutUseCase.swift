//
//  GetTextAboutUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 23.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class GetTextAboutUseCase: UseCase {
    typealias Input = Void
    typealias Output = AboutTextRepositoryResult

    private let repository: AboutTextRepository

    init(repository: AboutTextRepository) {
        self.repository = repository
    }

    func execute(with _: Void) -> Observable<AboutTextRepositoryResult> {
        return repository.getText()
    }
}
