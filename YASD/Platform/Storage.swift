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
    
    func getSize(id: String) -> Int64 {
        return getUrl(from: id)?.fileSize ?? 0
    }
    
    func clear(id: String) throws {
        if let url = getUrl(from: id) {
            try FileManager.default.removeItem(at: url)
        }
    }
    
    private func getUrl(from: String) -> URL? {
        return try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(from, isDirectory: false)
    }
}

private extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }

    var fileSize: Int64 {
        return attributes?[.size] as? Int64 ?? Int64(0)
    }
}
