//
//  WordsTableViewCell.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 13/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import UIKit

class WordsTableViewCell: UITableViewCell {    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var buttonPlay: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
