//
//  AboutViewController.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 09.05.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import RMessage
import RxSwift
import UIKit

class AboutViewController: UIViewController {
    var viewModel: AboutViewModel!

    @IBOutlet var textView: UITextView!

    private let disposeBag = DisposeBag()
    private let rmController = RMController()

    override func viewDidLoad() {
        super.viewDidLoad()

        rmController.presentationViewController = self
        bindToModel()
    }

    private func bindToModel() {
        let output = viewModel.transform(from: AboutViewModel.Input())
        disposeBag.insert(
            output.text.map { [weak self] result -> NSAttributedString in
                result.onFailure(self?.rmController.handleError)
                    .getOrDefault(NSAttributedString())
            }.drive(textView.rx.attributedText)
        )
    }
}
