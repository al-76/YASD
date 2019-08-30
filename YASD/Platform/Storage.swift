//
//  Storage.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/08/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation

class Storage {
    func get<T: Codable>(id: String, defaultObject: T) -> T {
        guard let url = getUrl(from: id),
            FileManager.default.fileExists(atPath: url.path),
            let data = FileManager.default.contents(atPath: url.path) else { return defaultObject }
        
        let decoder = JSONDecoder()
        return (try? decoder.decode(T.self, from: data)) ?? defaultObject
    }
    
    func save<T: Codable>(id: String, object: T) throws {
        guard let url = getUrl(from: id) else { return }
        let encoder = JSONEncoder()
        let data = try encoder.encode(object)
        FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
    }
    
    fileprivate func getUrl(from: String) -> URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(from, isDirectory: false)
    }
}
