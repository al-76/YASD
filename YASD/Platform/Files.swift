//
//  Files.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 13/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import Foundation

class Files {
    func createTempFile(name: String) throws -> URL {
        var directory = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        directory.appendPathComponent(name)
        return directory
    }
}
