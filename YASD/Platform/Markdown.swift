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
        return Markdown.getParser().parse(data)
    }
    
    private class func getParser() -> MarkdownParser {
        if #available(iOS 13.0, *) {
            return MarkdownParser(font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
                                  color: UIColor.label,
                                  enabledElements: .all,
                                  customElements: [])
        } else {
            return MarkdownParser(font: UIFont.systemFont(ofSize: UIFont.systemFontSize))
        }
    }
}
