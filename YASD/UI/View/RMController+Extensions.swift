//
//  RMController+Extensions.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 03.07.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RMessage

extension RMController {
    func handleError(_ error: Error) {
        showMessage(withSpec: errorSpec,
                                 title: "Error",
                                 body: error.localizedDescription)
    }
}
