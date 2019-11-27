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
    var searchResultsController: WordsSuggestionTableViewController!
    
    private var searchController: UISearchController!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
        bindToModel()
    }
    
    private func customizeView() {
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchBar.placeholder = "Skriv ett ord!"
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        navigationItem.searchController = searchController
        navigationItem.hidesBackButton = true
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
    }
    
    private func bindToModel() {
        searchController.searchBar.rx.text.compactMap { $0 }
            .asDriver(onErrorJustReturn: "")
            .drive(searchResultsController.searchText)
            .disposed(by: disposeBag)
        let input = WordsViewModel.Input(searchBar: createSearchDriver())
        model.transform(from: input)
            .foundWords.map { [weak self] result -> [FormattedWord] in
                return result.handleResult([], self?.handleError)
            }
            .drive(tableView.rx.items(cellIdentifier: "WordsTableCell")) { [weak self] (_, result, cell) in
                if let wordsCell = cell as? WordsTableViewCell {
                    wordsCell.textView.attributedText = result.formatted
                    self?.configureButtonPlay(wordsCell, with: result.soundUrl)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func createSearchDriver() -> Driver<String> {
        let inputText = { [weak self] () -> String in
            guard let text = self?.searchController.searchBar.text else { return "" }
            return text
        }
        let dismissSearchController: ((String) -> ()) = { [weak self] value in
            self?.searchController.searchBar.text = value
            self?.searchController.dismiss(animated: true, completion: nil)
        }
        let enteredText = searchController.searchBar.rx
            .searchButtonClicked
            .map { _ in inputText() }
            .asDriver(onErrorJustReturn: "")
        let suggestionText = searchResultsController.selectedSuggestion
            .asDriver(onErrorJustReturn: "")
        return Driver.merge(enteredText, suggestionText)
            .map { value in
                dismissSearchController(value)
                return value
        }
    }
        
    private func configureButtonPlay(_ cell: WordsTableViewCell, with url: String?) {
        cell.buttonPlay.isHidden = (url == nil)
        if url == nil {
            return
        }
        if cell.model == nil {
            cell.model = model.newCell()
        }
        let inputUrl = cell.buttonPlay.rx.tap.asDriver().map { [weak self] _ -> String in
            self?.animateButton(button: cell.buttonPlay)
            return url!
        }
        let output = cell.model
            .transform(from: WordsCellModel.Input(url: inputUrl))
        output.played.asObservable()
            .subscribe { [weak self] event in
                _ = event.element?.handleResult(false, self?.handleError)
            }
            .disposed(by: cell.disposeBag)
    }
    
    private func animateButton(button: UIButton) {
//        UIButton.animate(withDuration: 0.2,
//                         animations: {
//                            button.transform = CGAffineTransform(scaleX: 1, y: 1.5)
//        },
//                         completion: { finish in
//                            UIButton.animate(withDuration: 0.2, animations: {
//                                button.transform = CGAffineTransform.identity
//                            })
//        })
    }
    
    private func handleError(_ error: Error) {
        print(error) // TODO: show alert
    }
}
