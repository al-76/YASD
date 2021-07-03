//
//  SettingsTableViewController.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/07/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RMessage

class SettingsTableViewController: UITableViewController {
    var viewModel: SettingsViewModel!
    
    let disposeBag = DisposeBag()
    private let rmController = RMController()
    
    private let clearHistory = PublishRelay<Void>()
    private let clearCache = PublishRelay<Void>()
    
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var clearHistoryLabel: UILabel!
    @IBOutlet weak var clearCacheLabel: UILabel!
    @IBOutlet var clearHistoryGesture: UITapGestureRecognizer!
    @IBOutlet var clearCacheGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rmController.presentationViewController = self
        bindToModel()
    }
    
    private func bindToModel() {
        let output = viewModel.transform(from: SettingsViewModel.Input(clearHistory: clearHistory.asDriver(onErrorJustReturn: ()),
                                                          clearCache: clearCache.asDriver(onErrorJustReturn: ())))
        disposeBag.insert(
            output.selectedLanguage.map { [weak self] result -> String in
                result.onFailure { self?.handleError($0) }
                    .getOrDefault(Language.defaultLanguage).name
            }
            .drive(languageLabel.rx.text),
            output.historySize.drive(onNext: { [weak self] size in
                self?.clearHistoryLabel.insertValue(size)
            }),
            output.cacheSize.drive(onNext: { [weak self] size in
                self?.clearCacheLabel.insertValue(size)
            }),
            clearHistoryGesture.rx.event.asDriver().drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.showAlert(text:  NSLocalizedString("clearHistory", comment: ""),
                               relay: self.clearHistory)
            }),
            clearCacheGesture.rx.event.asDriver().drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.showAlert(text: NSLocalizedString("clearCache", comment: ""),
                               relay: self.clearCache)
            })
        )
        
    }
    
    private func showAlert(text: String, relay: PublishRelay<Void>) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: text, style: .destructive) { (action) in
            relay.accept(())
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(action)
        actionSheet.addAction(cancelAction)

        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func handleError(_ error: Error) {
        rmController.showMessage(withSpec: errorSpec,
                                 title: "Error",
                                 body: error.localizedDescription)
    }
}

private extension UILabel {
    func insertValue(_ value: String) {
        let regex = "(.*\\().+(\\).*)"
        text = text?.replacingOccurrences(of: regex, with: "$1\(value)$2", options: [.regularExpression])
    }
}
