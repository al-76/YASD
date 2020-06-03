//
//  MockPlayerServiceProvider.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 14.05.2020.
//  Copyright © 2020 yac. All rights reserved.
//

@testable import YASD

import RxSwift
import Cuckoo

extension MockFactory {
    enum SomeError: Error {
        case error
    }
    
    static func createMockPlayerService() -> MockPlayerManager {
        return createMockPlayerService(errorUrl: "", error: SomeError.error)
    }
    
    static func createMockPlayerService(errorUrl: String, error: Error) -> MockPlayerManager {
        let mock = MockPlayerManager()
        stub(mock) { stub in
            when(stub.playSound(with: anyString())).then { stringUrl in
                return Observable<PlayerServiceResult>.create {
                    observable in
                    if stringUrl == errorUrl {
                        observable.on(.error(error))
                    } else {
                        observable.on(.next(.success(true)))
                    }
                    observable.onCompleted()
                    return Disposables.create {}
                }
            }
        }
        return mock
    }
}
