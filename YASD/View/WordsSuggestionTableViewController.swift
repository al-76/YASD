//
//  WordsSuggestionTableViewController.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 10.10.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WordsSuggestionTableViewController: UITableViewController {
    var model: WordsSuggestionViewModel!
    let disposeBag = DisposeBag()
    let searchText = BehaviorRelay<String>(value: "")
    let forHistoryText = BehaviorRelay<String>(value: "")
    let selectedSuggestion = BehaviorRelay<String>(value: "")
    let completed = BehaviorRelay<String>(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customizeView()
        bindToModel()
    }
    
    private func customizeView() {
        clearsSelectionOnViewWillAppear = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    private func bindToModel() {
        let input = WordsSuggestionViewModel.Input(searchText: searchText.asDriver(), forHistory: forHistoryText.asDriver())
        model.transform(from: input).suggestions
        .map { [weak self] result -> [SuggestionItem] in
            return result.handleResult([], self?.handleError)
        }
        .drive(tableView.rx.items(cellIdentifier: "WordsSuggestionTableCell")) { (_, result, cell) in
            if let suggestionCell = cell as? WordsSuggestionTableViewCell {
                suggestionCell.label.text = result.suggestion
//                suggestionCell.removeButton
            }
        }
        .disposed(by: self.disposeBag)
                
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] index in
            guard let self = self else { return }
            self.selectedSuggestion.accept(self.suggestion(index))
        }).disposed(by: self.disposeBag)
    }
    
    private func suggestion(_ index: IndexPath) -> String {
        guard let cell = tableView.cellForRow(at: index) as? WordsSuggestionTableViewCell,
            let text = cell.label.text else { return "" }
        return text
    }
    
    private func handleError(_ error: Error) {
        print(error) // TODO: show alert
    }
}
