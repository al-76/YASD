//
//  MarkdownParser.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15/06/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit
import MarkdownKit

class Markdown {
    func parse(data: String) -> NSAttributedString {
        return MarkdownParser().parse(data)
    }
}
