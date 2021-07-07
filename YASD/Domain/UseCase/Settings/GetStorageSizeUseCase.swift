//
//  GetStorageSizeUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class GetStorageSizeUseCase<T: Codable & Equatable>: UseCase {
    typealias Input = Void
    typealias Output = String

    private let history: AnyStorageRepository<T>

    init(history: AnyStorageRepository<T>) {
        self.history = history
    }

    func execute(with _: Void) -> Observable<String> {
        return history.getSize().map { value in
            ByteCountFormatter.string(fromByteCount: value,
                                      countStyle: .file)
        }
    }
}
