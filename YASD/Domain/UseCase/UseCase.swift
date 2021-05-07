//
//  UseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 17.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import RxSwift

protocol UseCase {
    associatedtype Input
    associatedtype Output
    
    func execute(with input: Input) -> Observable<Output>
}

class AnyUseCase<Input, Output>: UseCase {
    private let executeObject: (_ input: Input) -> Observable<Output>
    
    init<TypeUseCase: UseCase>(wrapped: TypeUseCase)
    where TypeUseCase.Input == Input, TypeUseCase.Output == Output {
        executeObject = wrapped.execute
    }
    
    func execute(with input: Input) -> Observable<Output> {
        return executeObject(input)
    }
}
