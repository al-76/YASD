//
//  UISearchBar+Rx.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 10.10.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: UISearchBar {
    public var editedText: ControlEvent<String> {
        let source = text.map {
            [weak searchBar = self.base as UISearchBar] _ in searchBar?.text ?? "" }
        return ControlEvent(events: source)
    }
}
