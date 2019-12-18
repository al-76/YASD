//
//  VisibleTableView.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 12.12.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit

class SearchResultsTableView: UITableView {
    // Because of 'showsSearchResultsController' is only available for iOS13 and above we use a special view that is always isHidden == false.
    override var isHidden: Bool {
        get {
            if #available(iOS 13.0, *) {
                return super.isHidden
            } else {
                return false
            }
        }
        set {
            if #available(iOS 13.0, *) {
                super.isHidden = newValue
            }
        }
    }
}
