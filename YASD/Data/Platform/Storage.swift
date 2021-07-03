//
//  Storage.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/08/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation

protocol Storage {
    func get<T: Codable>(id: String, defaultObject: T) -> T
    func save<T: Codable>(id: String, object: T) throws
    func getSize(id: String) -> Int64
    func clear(id: String) throws
}
