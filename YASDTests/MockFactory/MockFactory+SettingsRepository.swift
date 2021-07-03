//
//  MockFactory+SettingsRepository.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 23.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import RxSwift
import Cuckoo

extension MockFactory {
    static func createMockSettingsRepository(_ publishSubject: PublishSubject<Language>) -> MockSettingsRepository {
        let mock = MockSettingsRepository()
        stub(mock) { stub in
            when(stub.getLanguage()).then { _ in .just(.success(Language(name: "test", code: "test"))) }
            when(stub.getLanguageBehaviour()).then { _ in publishSubject }
        }
        return mock
    }
}
