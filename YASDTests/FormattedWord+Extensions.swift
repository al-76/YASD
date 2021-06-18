//
//  FormattedWord+Extensions.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 14.05.2020.
//  Copyright © 2020 yac. All rights reserved.
//

@testable import YASD
import Foundation

extension FormattedWord {
    public init(_ header: String) {
        self.init(header: header, formatted: NSAttributedString(), soundUrl: nil, definition: "")
    }
}
