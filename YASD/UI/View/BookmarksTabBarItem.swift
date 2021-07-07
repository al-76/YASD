//
//  BookmarksTabBarItem.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 07.07.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import UIKit

class BookmarksTabBarItem: UITabBarItem {
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        if #available(iOS 13, *) {
            // nothing
        } else {
            // XXX: there's weird bug with assets - bookmark loads as bookmark.fill
            image = UIImage(named: "fill_bookmark")
        }
    }
}
