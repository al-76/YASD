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
