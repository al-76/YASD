//
//  Mapper.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 28.06.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import Foundation

protocol Mapper {
    associatedtype Input
    associatedtype Output

    func map(input: Input) -> Output
}
