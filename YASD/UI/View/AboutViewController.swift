//
//  AboutViewController.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 09.05.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    var aboutText: AboutTextRepository!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.attributedText = aboutText.getText()
    }
}
