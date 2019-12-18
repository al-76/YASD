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
    private let playUrl = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
        bindToModel()
    }
    
    private func customizeView() {
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchBar.placeholder = "Skriv ett ord!"
        if #available(iOS 13.0, *) {
            searchController.showsSearchResultsController = true
        }
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
        searchController.searchBar.rx.text.distinctUntilChanged()
            .compactMap { $0 }.asDriver(onErrorJustReturn: "")
            .drive(searchResultsController.searchText)
            .disposed(by: disposeBag)
        let input = WordsViewModel.Input(searchBar: createSearchDriver(), playUrl: playUrl.asDriver().filter { $0 != "" })
        let output = model.transform(from: input)
        output.foundWords.map { [weak self] result -> [FormattedWord] in
                return result.handleResult([], self?.handleError)
            }
            .drive(tableView.rx.items(cellIdentifier: "WordsTableCell")) { [weak self] (_, result, cell) in
                if let wordsCell = cell as? WordsTableViewCell {
                    wordsCell.textView.attributedText = result.formatted
                    self?.configureButtonPlay(wordsCell, with: result.soundUrl)
                }
            }
            .disposed(by: disposeBag)
        output.played.asObservable()
            .subscribe(onNext: { [weak self] result in
            _ = result.handleResult(false, self?.handleError)
        }).disposed(by: disposeBag)
    }
    
    private func createSearchDriver() -> Driver<String> {
        let inputText = { [weak self] () -> String in
            guard let text = self?.searchController.searchBar.text else { return "" }
            return text
        }
        let dismissSearchController: ((String) -> ()) = { [weak self] value in
            self?.searchResultsController.forHistoryText.accept(value)
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
//        if cell.model == nil {
//            cell.model = model.newCell()
//        }
        cell.buttonPlay.rx.tap.asDriver()
            .map { url ?? "" }
            .drive(playUrl)
            .disposed(by: disposeBag)
//        let output = cell.model
//            .transform(from: WordsCellModel.Input(url: inputUrl))
//        output.played.asObservable()
//            .subscribe { [weak self] event in
//                _ = event.element?.handleResult(false, self?.handleError)
//            }
//            .disposed(by: cell.disposeBag)
    }
    
    private func handleError(_ error: Error) {
        print(error) // TODO: show alert
    }
}
