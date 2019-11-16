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
    let selectedSuggestion = BehaviorRelay<String>(value: "")
    
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
        let text = searchText.asDriver(onErrorJustReturn: "")
        let input = WordsSuggestionViewModel.Input(searchBar: text)
        model.transform(input: input).suggestions.map { [weak self] result -> [LexinParserSuggestionResultItem] in
            return result.handleResult([], self?.handleError)
        }
        .drive(tableView.rx.items(cellIdentifier: "WordsSuggestionTableCell")) { (_, result, cell) in
            if let suggestionCell = cell as? WordsSuggestionTableViewCell {
                suggestionCell.label.text = result
            }
        }
        .disposed(by: self.disposeBag)
                
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] index in
            guard let self = self else { return }
            self.selectedSuggestion.accept(self.suggestion(index: index))
        }).disposed(by: self.disposeBag)
    }
    
    private func suggestion(index: IndexPath) -> String {
        guard let cell = tableView.cellForRow(at: index) as? WordsSuggestionTableViewCell,
            let text = cell.label.text else { return "" }
        return text
    }
    
    private func handleError(error: Error) {
        print(error) // TODO: show alert
    }
}
