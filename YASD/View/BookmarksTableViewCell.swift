//
//  BookmarksTableViewCell.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 24.12.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit
import RxSwift

class BookmarksTableViewCell: UITableViewCell {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var buttonPlay: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
