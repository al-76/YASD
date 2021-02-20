//
//  Language.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 20.02.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation

struct Language: Codable {
    var name: String
    var code: String
}

extension Language: Equatable {
    static public func == (lhs: Language, rhs: Language) -> Bool {
        return (lhs.name == rhs.name && lhs.code == rhs.code)
    }
}
