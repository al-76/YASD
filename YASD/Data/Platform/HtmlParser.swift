//
//  HtmlParser.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15/06/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation

protocol HtmlParserElement {
    func attribute(_ id: String) throws -> String
    func text() throws -> String
    func selectText(_ query: String) throws -> String
    func selectTexts(_ query: String) throws -> [String]
    func selectElements(_ query: String) throws -> [HtmlParserElement]
}

protocol HtmlParser {
    func parse(html: String, query: String) throws -> [HtmlParserElement]
}
