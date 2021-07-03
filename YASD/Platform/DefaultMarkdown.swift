//
//  DefaultMarkdown.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 03.07.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import MarkdownKit

class DefaultMarkdown: Markdown {
    func parse(data: String) -> NSAttributedString {
        return DefaultMarkdown.getParser().parse(data)
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
