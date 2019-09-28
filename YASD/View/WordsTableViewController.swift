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
        searchController.obscuresBackgroundDuringPresentation = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.tableHeaderView = searchController.searchBar
        tableView.reloadData()
    }
    
    private func bindToModel() {
        let input = WordsViewModel.Input(searchBar: createTextDriver())
        model.transform(input: input)
            .foundWords.map { [weak self] result -> [LexinServiceResultFormattedItem] in
                switch result {
                case .success(let items):
                    return items
                case .failure(let error):
                    self?.handleError(error: error)
                    return []
                }
            }
            .drive(tableView.rx.items(cellIdentifier: "WordsTableCell")) { [weak self] (_, result, cell) in
                if let wordsCell = cell as? WordsTableViewCell {
                    wordsCell.textView.attributedText = result.formatted
                    self?.configureButtonPlay(cell: wordsCell, url: result.soundUrl)
                }
            }
            .disposed(by: self.disposeBag)
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
    
    private func configureButtonPlay(cell: WordsTableViewCell, url: String?) {
        cell.buttonPlay.isHidden = (url == nil)
        if url == nil {
            return
        }
        cell.buttonPlay.isHidden = false
        if cell.model == nil {
            cell.model = model.newCell()
        }
        let inputUrl = cell.buttonPlay.rx.tap.asDriver().map { url! }
        let output = cell.model
            .transform(input: WordsCellModel.Input(url: inputUrl))
        output.played.asObservable()
            .subscribe { [weak self] event in
                if let played = event.element {
                    switch played {
                    case .success:
                        break
                    case .failure(let error):
                        self?.handleError(error: error)
                        break
                    }
                }
            }
            .disposed(by: cell.disposeBag)
    }
    
    private func handleError(error: Error) {
        print(error) // TODO: show alert
    }
}
