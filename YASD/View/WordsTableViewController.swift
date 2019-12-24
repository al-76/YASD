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
    private let playUrl = PublishRelay<String>()
    private let addBookmark = PublishRelay<FormattedWord>()
    private let removeBookmark = PublishRelay<FormattedWord>()
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
        let input = WordsViewModel.Input(search: createSearchDriver(),
                                         playUrl: playUrl.asDriver(onErrorJustReturn: ""),
                                         addBookmark: addBookmark.asDriver(onErrorJustReturn: FormattedWord()),
                                         removeBookmark: removeBookmark.asDriver(onErrorJustReturn: FormattedWord()))
        let output = model.transform(from: input)
        disposeBag.insert(
            searchController.searchBar.rx.text.distinctUntilChanged()
                .compactMap { $0 }
                .bind(to: searchResultsController.search),
            output.foundWords.map { [weak self] result -> [FormattedWord] in
                return result.handleResult([], self?.handleError)
            }
            .drive(tableView.rx.items(cellIdentifier: "WordsTableCell")) { [weak self] (_, result, cell) in
                if let wordsCell = cell as? WordsTableViewCell {
                    wordsCell.textView.attributedText = result.formatted
                    self?.configureButtonPlay(wordsCell, with: result.soundUrl)
                    self?.configureButtonBookmark(wordsCell, with: result)
                }
            },
            Driver.merge(output.played, output.bookmarked).drive(onNext: { [weak self] result in
                _ = result.handleResult(false, self?.handleError)
            })
        )
    }
    
    private func createSearchDriver() -> Driver<String> {
        let inputText = { [weak self] () -> String in
            guard let text = self?.searchController.searchBar.text else { return "" }
            return text
        }
        let dismissSearchController: ((String) -> ()) = { [weak self] value in
            self?.searchResultsController.addHistory.accept(value)
            self?.searchController.searchBar.text = value
            self?.searchController.dismiss(animated: true, completion: nil)
        }
        let enteredText = searchController.searchBar.rx
            .searchButtonClicked
            .map { _ in inputText() }
            .asDriver(onErrorJustReturn: "")
        let suggestionText = searchResultsController.selectSuggestion
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
        cell.buttonPlay.rx.tap
            .map { url ?? "" }
            .bind(to: playUrl)
            .disposed(by: disposeBag)
    }
    
    private func configureButtonBookmark(_ cell: WordsTableViewCell, with word: FormattedWord) {
        let tapped = cell.buttonBookmark.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .map({ _ -> UIButton in
                cell.buttonBookmark.isSelected = !cell.buttonBookmark.isSelected
                return cell.buttonBookmark
            }).share()
        disposeBag.insert(
            tapped.filter { $0.isSelected }
                .map { _ in word }
                .bind(to: addBookmark),
            tapped.filter { !$0.isSelected }
                .map { _ in word }
                .bind(to: removeBookmark)
            )
    }
    
    private func handleError(_ error: Error) {
        print(error) // TODO: show alert
    }
}
