//
//  GetHistorySizeUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class GetHistorySizeUseCase: UseCase {
    typealias Input = Void
    typealias Output = String

    private let history: AnyStorageRepository<Suggestion>

    init(history: AnyStorageRepository<Suggestion>) {
        self.history = history
    }

    func execute(with _: Void) -> Observable<String> {
        return history.getSize().map { value in
            ByteCountFormatter.string(fromByteCount: value,
                                      countStyle: .file)
        }
    }
}
