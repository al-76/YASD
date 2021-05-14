//
//  MockFactory+UseCase.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 14.05.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

extension MockFactory {
    static func createUseCaseStub<Input, Output>() -> AnyUseCaseStub<Input, Output> {
        return AnyUseCaseStub<Input, Output>(wrapped: UseCaseStub())
    }
}
