//
//  FormattedWord+Extensions.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 14.05.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import Foundation
@testable import YASD

extension FormattedWord {
    init(_ header: String) {
        self.init(header: header, formatted: NSAttributedString(), soundUrl: nil, definition: "")
    }
}
