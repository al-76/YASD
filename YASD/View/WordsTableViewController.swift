//
//  FirstViewController.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WordsTableViewController: UITableViewController {
    var model: WordsViewModel!
    let searchController = UISearchController(searchResultsController: nil)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
        bindToModel()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        searchController.searchBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchController.searchBar.isHidden = false
    }
    
    private func customizeView() {
        searchController.dimsBackgroundDuringPresentation = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.tableHeaderView = searchController.searchBar
        tableView.reloadData()
    }
    
    private func bindToModel() {
        let input = WordsViewModel.Input(searchBar: createTextDriver())
        model.transform(input: input)
            .foundWords.map { [weak self] result -> [NSAttributedString] in
                switch result {
                case .success(let items):
                    return items
                case .failure(let error):
                    self?.handleError(error: error)
                    return []
                }
            }.drive(tableView.rx.items(cellIdentifier: "WordsTableCell")) { (_, result, cell) in
                if let wordsCell = cell as? WordsTableViewCell {
                    wordsCell.textView.attributedText = result
                }
            }.disposed(by: self.disposeBag)
    }
    
    private func createTextDriver() -> Driver<String> {
        let inputText = { [weak self] in self?.searchController.searchBar.text }
        let editedText = searchController.searchBar.rx
            .textDidEndEditing.asDriver()
            .map { _ in inputText() }
        let deletedText = searchController.searchBar.rx
            .text.asDriver()
            .filter { _ in inputText() == "" }
            .map { _ in inputText() }
        return Driver.merge(editedText, deletedText)
            .distinctUntilChanged()
            .map { text in text ?? "" }
    }
    
    private func handleError(error: Error) {
        print(error) // TODO: show alert
    }
}
