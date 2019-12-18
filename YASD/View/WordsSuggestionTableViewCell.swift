//
//  WordsSuggestionTableViewCell.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 10.10.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit

class WordsSuggestionTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var iconHistory: UIImageView!
    @IBOutlet weak var buttonRemove: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRemovable(_ value: Bool) {
        iconHistory.isHidden = !value
        buttonRemove.isHidden = !value
    }
}
