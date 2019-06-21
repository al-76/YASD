//
//  Result.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 22/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//

enum Result<T> {
    case success(T)
    case failure(Error)
}

extension Result: Equatable where T: Equatable {
    static func == (lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
        case let (.success(lhs), .success(rhs)):
            return lhs == rhs
        case (.failure, .failure):
            return true
        case (.success, .failure), (.failure, .success):
            return false
        }
    }
}

extension Result {
    func getResult() -> T? {
        switch (self) {
        case let .success(value):
            return value
        default:
            return nil
        }
    }
}
