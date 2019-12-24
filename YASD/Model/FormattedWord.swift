//
//  FormattedWord.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation

struct FormattedWord: Codable {
    let formatted: NSAttributedString
    let soundUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case formatted
        case soundUrl
    }
    
    public init() {
        self.init(formatted: NSAttributedString(), soundUrl: nil)
    }
    
    public init(formatted: NSAttributedString, soundUrl: String?) {
        self.formatted = formatted
        self.soundUrl = soundUrl
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let attributedString = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(container.decode(Data.self, forKey: .formatted)) as? NSAttributedString else {
            throw DecodingError.dataCorruptedError(forKey: .formatted, in: container, debugDescription: "Data is corrupted")
        }
        self.formatted = attributedString
        self.soundUrl = try container.decode(String.self, forKey: .soundUrl)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(NSKeyedArchiver.archivedData(withRootObject: formatted, requiringSecureCoding: false), forKey: .formatted)
        try container.encode(soundUrl, forKey: .soundUrl)
    }
}

extension FormattedWord: Equatable {
    static public func == (lhs: FormattedWord, rhs: FormattedWord) -> Bool {
        return lhs.formatted == rhs.formatted && lhs.soundUrl == rhs.soundUrl
    }
}

typealias FormattedWordResult = Result<[FormattedWord]>
