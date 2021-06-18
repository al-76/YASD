//
//  AboutViewController.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 09.05.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import UIKit
import RxSwift

class AboutViewController: UIViewController {
    var viewModel: AboutViewModel!
    
    @IBOutlet weak var textView: UITextView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let output = viewModel.transform(from: AboutViewModel.Input())
        disposeBag.insert(
            output.text.drive(textView.rx.attributedText)
        )
    }
}
