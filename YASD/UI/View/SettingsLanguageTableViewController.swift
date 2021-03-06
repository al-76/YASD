//
//  SettingsLanguageTableViewController.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RMessage
import RxCocoa
import RxSwift
import UIKit

class SettingsLanguageTableViewController: UITableViewController {
    var viewModel: SettingsLanguageViewModel!

    private let disposeBag = DisposeBag()
    private var searchController: UISearchController!
    private let rmController = RMController()

    override func viewDidLoad() {
        super.viewDidLoad()

        rmController.presentationViewController = self
        customizeView()
        bindToModel()
    }

    private func customizeView() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = NSLocalizedString("searchLanguage", comment: "")
        searchController.obscuresBackgroundDuringPresentation = false

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        tableView.dataSource = nil
        tableView.delegate = nil
    }

    private func bindToModel() {
        let language = tableView.rx.itemSelected.map { [weak self] in
            guard let table = self?.tableView else {
                return ""
            }
            table.cellForRow(at: $0)?.accessoryType = .checkmark
            let item = try? table.rx.model(at: $0) as SettingsLanguageItem
            self?.searchController.dismiss(animated: true, completion: nil)
            return (item?.language.name ?? "")
        }.asDriver(onErrorJustReturn: "")
        let searchLanguage = searchController.searchBar.rx.text
            .distinctUntilChanged()
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: "")
        let input = SettingsLanguageViewModel.Input(search: searchLanguage, select: language)
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            // deselected items
            tableView.rx.itemDeselected.asObservable().subscribe(onNext: { [weak self] in
                self?.tableView.cellForRow(at: $0)?.accessoryType = .none
            }),
            // languages
            output.languages.map { [weak self] result -> [SettingsLanguageItem] in
                result.onFailure(self?.rmController.handleError)
                    .getOrDefault([])
            }
            .drive(tableView.rx.items(cellIdentifier: "SettingsTableCell")) { _, result, cell in
                if let settingsCell = cell as? SettingsLanguageTableViewCell,
                   let cellLabel = settingsCell.textLabel {
                    cellLabel.text = result.language.name
                }
                cell.accessoryType = (result.selected ? .checkmark : .none)
            }
        )
    }
}
