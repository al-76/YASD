//
//  SettingsLanguageTableViewController.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsLanguageTableViewController: UITableViewController {
    var model: SettingsLanguageViewModel!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindToModel()
    }
    
    private func bindToModel() {
        tableView.rx.itemDeselected.asObservable().subscribe(onNext: { [weak self] in
            self?.tableView.cellForRow(at: $0)?.accessoryType = .none
        }).disposed(by: disposeBag)
        let language = tableView.rx.itemSelected.map { [weak self] in
            guard let table = self?.tableView else {
                return ""
            }
            table.cellForRow(at: $0)?.accessoryType = .checkmark
            let item = try? table.rx.model(at: $0) as SettingsItem
            return (item?.language.name ?? "")
            }.asDriver(onErrorJustReturn: "")
        let input = SettingsLanguageViewModel.Input(selectedLanguage: language)
        let output = model.transform(from: input)
        output.languages.drive(tableView.rx.items(cellIdentifier: "SettingsTableCell")) { (_, result, cell) in
                if let settingsCell = cell as? SettingsLanguageTableViewCell,
                    let cellLabel = settingsCell.textLabel {
                    cellLabel.text = result.language.name
                }
                cell.accessoryType = (result.selected ? .checkmark : .none)
            }.disposed(by: disposeBag)
    }
}
