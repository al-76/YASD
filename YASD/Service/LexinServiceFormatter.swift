//
//  LexinService+Format.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 07/06/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation

typealias LexinServiceResultFormatted = Result<[NSAttributedString]>

class LexinServiceFormatter {
    private let markdown: Markdown
    
    init(markdown: Markdown) {
        self.markdown = markdown
    }
    
    func format(result: LexinServiceResult) -> LexinServiceResultFormatted {
        switch result {
        case .success(let items):
            return .success(items.map { format(item: $0) })
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func format(item: LexinServiceResultItem) -> NSAttributedString {
        let phonetic = "[" + (item.baseLang.phonetic ?? "") + "]"
        let word = "# " + item.word + " " + phonetic + " " + textType(text: item.type ?? "") + "\n"
        let inflection = "### (" + item.word + textInflection(lang: item.baseLang) + ")\n"
        let meaning = textOrEmpty(text: item.baseLang.meaning ?? "")
        let translation = textOrEmpty(text: item.targetLang?.translation ?? "")
        let example = textTranslatedItems(items1opt: item.baseLang.example, items2opt: item.targetLang?.example)
        let idiom = textTranslatedItems(items1opt: item.baseLang.idiom, items2opt: item.targetLang?.idiom)
        let compound = textTranslatedItems(items1opt: item.baseLang.compound, items2opt: item.targetLang?.compound)
        return self.markdown.parse(data: word +
            inflection +
            meaning +
            translation +
            addLabel(to: idiom, label: "Uttryck") +
            addLabel(to: example, label: "Exempel") +
            addLabel(to: compound, label: "Sammansättningar"))
    }
    
    private func textInflection(lang: LexinServiceResultItem.Lang) -> String {
        return lang.inflection?
            .compactMap { $0 }
            .reduce("") { $0 + ", " + $1 } ?? ""
    }
    
    private func textTranslatedItems(items1opt: [LexinServiceResultItem.Item]?, items2opt: [LexinServiceResultItem.Item]?) -> String {
        let separator = "\n* "
        var res = ""
        if let items1 = items1opt,
            let items2 = items2opt {
            res = textMatchedItems(items1: items1, items2: items2, separator: separator)
        } else if let items1 = items1opt {
            res = items1
                .compactMap { $0.value }
                .reduce("") { $0 + separator + $1 }
        }
        return res
    }
    
    private func textMatchedItems(items1: [LexinServiceResultItem.Item], items2: [LexinServiceResultItem.Item], separator: String) -> String {
        let matchedItems = items1.compactMap { first in
            ( first, items2.first { $0.id == first.id } ) }
            .compactMap { $0 }
        return matchedItems.compactMap { pair in
            var res = pair.0.value
            if let item = pair.1 {
                res += " - " + item.value
            }
            return res }
            .reduce("") { $0 + separator + $1 }
    }
    
    private func addLabel(to: String, label: String) -> String {
        return (to == "" ? "" : "\n## " + label + ":" + to + "\n")
    }
    
    private func textOrEmpty(text: String) -> String {
        return (text == "" ? "" : text + "\n");
    }
    
    private func textType(text: String) -> String {
        return (text == "" ? "" : "(" + text + ")")
    }
}
