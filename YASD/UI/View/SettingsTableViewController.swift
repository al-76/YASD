//
//  SettingsTableViewController.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/07/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import BuyMeACoffee
import RMessage
import RxCocoa
import RxSwift
import UIKit

class SettingsTableViewController: UITableViewController {
    var viewModel: SettingsViewModel!

    let disposeBag = DisposeBag()
    private let rmController = RMController()

    private let clearHistory = PublishRelay<Void>()
    private let clearCache = PublishRelay<Void>()
    private let clearBookmarks = PublishRelay<Void>()

    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var clearHistoryLabel: UILabel!
    @IBOutlet var clearCacheLabel: UILabel!
    @IBOutlet weak var clearBookmarksLabel: UILabel!
    @IBOutlet var clearHistoryGesture: UITapGestureRecognizer!
    @IBOutlet var clearCacheGesture: UITapGestureRecognizer!
    @IBOutlet var clearBookmarksGesture: UITapGestureRecognizer!

    override func viewDidLoad() {
        super.viewDidLoad()

        rmController.presentationViewController = self
        bindToModel()
        configureBMC()
    }

    private func bindToModel() {
        let input = SettingsViewModel.Input(clearHistory: clearHistory.asDriver(onErrorJustReturn: ()),
                                            clearCache: clearCache.asDriver(onErrorJustReturn: ()),
                                            clearBookmarks: clearBookmarks.asDriver(onErrorJustReturn: ()))
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            output.selectedLanguage.map { [weak self] result -> String in
                result.onFailure(self?.rmController.handleError)
                    .getOrDefault(Language.defaultLanguage).name
            }
            .drive(languageLabel.rx.text),
            output.historySize.drive(onNext: { [weak self] size in
                self?.clearHistoryLabel.insertValue(size)
            }),
            output.cacheSize.drive(onNext: { [weak self] size in
                self?.clearCacheLabel.insertValue(size)
            }),
            output.bookmarksSize.drive(onNext: { [weak self] size in
                self?.clearBookmarksLabel.insertValue(size)
            }),
            clearHistoryGesture.rx.event.asDriver().drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.showAlert(text: NSLocalizedString("clearHistory", comment: ""),
                               relay: self.clearHistory)
            }),
            clearCacheGesture.rx.event.asDriver().drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.showAlert(text: NSLocalizedString("clearCache", comment: ""),
                               relay: self.clearCache)
            }),
            clearBookmarksGesture.rx.event.asDriver().drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.showAlert(text: NSLocalizedString("clearBookmarks", comment: ""),
                               relay: self.clearBookmarks)
            })
        )
    }

    private func configureBMC() {
        BMCManager.shared.presentingViewController = self
        BMCManager.shared.thankYouMessage = "Thank you for supporting 🎉!"
    }

    private func showAlert(text: String, relay: PublishRelay<Void>) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: text, style: .destructive) { _ in
            relay.accept(())
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(action)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }
}

private extension UILabel {
    func insertValue(_ value: String) {
        let regex = "(.*\\().+(\\).*)"
        text = text?.replacingOccurrences(of: regex, with: "$1\(value)$2", options: [.regularExpression])
    }
}
