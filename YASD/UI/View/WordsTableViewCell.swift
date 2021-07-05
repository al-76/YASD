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
    @IBOutlet var textView: UITextView!
    @IBOutlet var buttonPlay: UIButton!
    @IBOutlet var buttonBookmark: UIButton!

    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        if #available(iOS 13, *) {
            // nothing
        } else {
            // XXX: there's weird bug with assets - bookmark loads as bookmark.fill
            buttonBookmark.setImage(UIImage(named: "fill_bookmark"), for: UIControl.State.selected)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
