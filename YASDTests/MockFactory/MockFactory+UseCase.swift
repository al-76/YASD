//
//  MockFactory+UseCase.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 14.05.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import Cuckoo

extension MockFactory {
    static func createUseCaseStub<Input, Output>() -> AnyUseCaseStub<Input, Output> {
        return AnyUseCaseStub<Input, Output>(wrapped: UseCaseStub())
    }
}

extension MockFactory {
    static func createMockUseCase<Input, Output>(onError: @escaping (Input) -> Error?,
                                                 onRxError: @escaping (Input) -> Output?,
                                                 onSuccess: @escaping (Input) -> Output?) -> MockAnyUseCase<Input, Output> {
        let mock = MockAnyUseCase(wrapped: MockUseCase<Input, Output>())
        stub(mock) { stub in
            when(stub.execute(with: any())).then { value in
                if let res = onError(value) {
                    return .error(res)
                } else if let res = onRxError(value) {
                    return .just(res)
                } else {
                    return .just(onSuccess(value)!)
                }
            }
        }
        return mock
    }
}
