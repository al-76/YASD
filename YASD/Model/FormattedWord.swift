//
//  FormattedWord.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation

struct FormattedWord: Codable {
    let header: String
    let formatted: NSAttributedString
    let soundUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case header
        case formatted
        case soundUrl
    }
    
    public init() {
        self.init(header: "", formatted: NSAttributedString(), soundUrl: nil)
    }
    
    public init(header: String, formatted: NSAttributedString, soundUrl: String?) {
        self.header = header
        self.formatted = formatted
        self.soundUrl = soundUrl
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let attributedString = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(container.decode(Data.self, forKey: .formatted)) as? NSAttributedString else {
            throw DecodingError.dataCorruptedError(forKey: .formatted, in: container, debugDescription: "Data is corrupted")
        }
        self.header = try container.decode(String.self, forKey: .header)
        self.formatted = attributedString
        self.soundUrl = try container.decode(String.self, forKey: .soundUrl)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(header, forKey: .header)
        try container.encode(NSKeyedArchiver.archivedData(withRootObject: formatted, requiringSecureCoding: false), forKey: .formatted)
        try container.encode(soundUrl, forKey: .soundUrl)
    }
}

extension FormattedWord: Equatable {
    static public func == (lhs: FormattedWord, rhs: FormattedWord) -> Bool {
        let res = (lhs.header == rhs.header &&
            lhs.formatted == rhs.formatted &&
            lhs.soundUrl == rhs.soundUrl)
        return res
    }
}

typealias FormattedWordResult = Result<[FormattedWord]>
