//
//  DefaultAboutTextRepository.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 20.02.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation

class DefaultAboutTextRepository: AboutTextRepository {
    let markdown: Markdown
    
    init(markdown: Markdown) {
        self.markdown = markdown
    }
    
    func getText() -> NSAttributedString {
        return markdown.parse(data: NSLocalizedString("textAbout", comment: ""))
    }
}
