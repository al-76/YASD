//
//  LexinService+Format.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 07/06/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation
import RxSwift

class LexinServiceFormatter {
    private let markdown: Markdown
    
    init(markdown: Markdown) {
        self.markdown = markdown
    }
    
    func format(result: LexinWordResult) -> FormattedWordResult {
        switch result {
        case .success(let items):
            return .success(items.map { FormattedWord(header: $0.word, formatted: format(item: $0), soundUrl: getSoundUrl(item: $0)) })
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func format(item: LexinWord) -> NSAttributedString {
        if let baseLang = item.baseLang {
            return markdown.parse(data: formatWordDefinition(lang: baseLang, item: item) + formatWordExample(lang: baseLang, targetLang: item.targetLang))
        } else if let lexemes = item.lexemes {
            var formatLexemes = ""
            for (i, lexeme) in lexemes.enumerated() {
                formatLexemes += formatWordExample(lang: lexeme, targetLang: nil)
                if lexemes.count - 1 != i {
                    formatLexemes += "\n"
                }
            }
            return markdown.parse(data: formatWordDefinition(lang: lexemes.first, item: item) + formatLexemes)
        }
        return markdown.parse(data: formatWordDefinition(lang: nil, item: item))
    }
    
    private func formatWordDefinition(lang: LexinWord.Lang?, item: LexinWord) -> String {
        var phonetic = ""
        if let langPhonetic = lang?.phonetic {
            phonetic = "[" + langPhonetic + "] "
        }
        var langReference = ""
        if let reference = lang?.reference { langReference = " " + reference }
        let word = "# " + item.word + " " + phonetic + (textType(text: (item.type ?? "") + langReference)) + "\n"
        var inflection = ""
        if let langInflection = lang?.inflection,
            langInflection.count > 0 {
            inflection = "### (" + item.word + ", " + textStrings(strings: langInflection) + ")\n"
        }
        return (word + inflection + formatTranslation(lang: lang, item: item))
    }
    
    private func formatTranslation(lang: LexinWord.Lang?, item: LexinWord) -> String {
        var translation = textOrEmpty(text: (item.targetLang?.translation ?? "") + formatSynonym(lang: item.targetLang))
        if translation == "" {
            translation = textOrEmpty(text: (lang?.translation ?? "") + formatSynonym(lang: lang))
        }
        return translation
    }
    
    private func formatSynonym(lang: LexinWord.Lang?) -> String {
        var res = ""
        if let synonym = lang?.synonym, synonym.count > 0 {
            res = " (" + textStrings(strings: synonym) + ")"
        }
        return res
    }
    
    private func formatWordExample(lang: LexinWord.Lang, targetLang: LexinWord.Lang?) -> String {
        let meaning = textItalicOrEmpty(text: lang.meaning ?? "")
        let example = textTranslatedItems(items1opt: lang.example, items2opt: targetLang?.example)
        let idiom = textTranslatedItems(items1opt: lang.idiom, items2opt: targetLang?.idiom)
        let compound = textTranslatedItems(items1opt: lang.compound, items2opt: targetLang?.compound)
        return (meaning +
            addLabel(to: idiom, label: "Uttryck") +
            addLabel(to: example, label: "Exempel") +
            addLabel(to: compound, label: "Sammansättningar"))
    }
    
    private func textStrings(strings: [String?]) -> String {
        return strings
            .compactMap { $0 }
            .joined(separator: ", ")
    }
    
    private func textTranslatedItems(items1opt: [LexinWord.Item]?, items2opt: [LexinWord.Item]?) -> String {
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
    
    private func textMatchedItems(items1: [LexinWord.Item], items2: [LexinWord.Item], separator: String) -> String {
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
    
    private func textItalicOrEmpty(text: String) -> String {
        return (text == "" ? "" : "*" + text + "*\n");
    }
    
    private func textType(text: String) -> String {
        return (text == "" ? "" : "(" + text + ")")
    }
    
    private func getSoundUrl(item: LexinWord) -> String? {
        if let baseLang = item.baseLang {
            return baseLang.soundUrl
        } else if let lexeme = item.lexemes?.first {
            return lexeme.soundUrl
        }
        return nil
    }
}
