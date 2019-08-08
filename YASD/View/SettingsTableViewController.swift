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

class SettingsTableViewController: UITableViewController {
    var model: SettingsViewModel!
    let disposeBag = DisposeBag()
    @IBOutlet weak var languageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindToModel()
    }
    
    private func bindToModel() {
        model.transform(input: SettingsViewModel.Input())
            .selectedLanguage
            .drive(languageLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
