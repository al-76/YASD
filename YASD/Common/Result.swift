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
        default:
            return false
        }
    }
}

extension Result {
    func getOrDefault(_ defaultValue: T) -> T {
        switch self {
        case let .success(value):
            return value
        default:
            return defaultValue
        }
    }
}

extension Result {
    @discardableResult
    func onSuccess(_ handler: (T) -> ()) -> Self {
        guard case let .success(value) = self else { return self }
        handler(value)
        return self
    }
    
    @discardableResult
    func onFailure(_ handler: (Error) -> ()) -> Self {
        guard case let .failure(error) = self else { return self }
        handler(error)
        return self
    }
}
