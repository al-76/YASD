//
//  FirstViewController.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RMessage
import RxCocoa
import RxSwift
import UIKit

class WordsTableViewController: UITableViewController {
    var viewModel: WordsViewModel!
    var searchResultsController: WordsSuggestionTableViewController!

    private var searchController: UISearchController!
    private let playUrl = PublishRelay<String>()
    private let addBookmark = PublishRelay<FormattedWord>()
    private let removeBookmark = PublishRelay<FormattedWord>()
    private let disposeBag = DisposeBag()
    private let rmController = RMController()

    @IBOutlet var labelLoading: UIStackView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        rmController.presentationViewController = self
        customizeView()
        bindToModel()
    }

    private func customizeView() {
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchBar.placeholder = NSLocalizedString("searchBar", comment: "")
        if #available(iOS 13.0, *) {
            searchController.showsSearchResultsController = true
        }

        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.tableFooterView = UIView()
        tableView.reloadData()

        navigationItem.searchController = searchController
        navigationItem.hidesBackButton = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.titleView = labelLoading

        definesPresentationContext = true

        if #available(iOS 13.0, *) {
            activityIndicator.style = .medium
        } else {
            activityIndicator.style = .white
        }
    }

    private func bindToModel() {
        let input = WordsViewModel.Input(search: createSearchDriver(),
                                         playUrl: playUrl.asDriver(onErrorJustReturn: ""),
                                         addBookmark: addBookmark.asDriver(onErrorJustReturn: FormattedWord()),
                                         removeBookmark: removeBookmark.asDriver(onErrorJustReturn: FormattedWord()))
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            // search
            searchController.searchBar.rx.text.distinctUntilChanged()
                .compactMap { $0 }
                .bind(to: searchResultsController.search),
            // found words
            output.foundWords.map { [weak self] result -> [FoundWord] in
                result.onFailure(self?.rmController.handleError)
                    .getOrDefault([])
            }
            .drive(tableView.rx.items(cellIdentifier: "WordsTableCell")) { [weak self] _, result, cell in
                if let wordsCell = cell as? WordsTableViewCell {
                    let word = result.word
                    wordsCell.textView.attributedText = word.formatted
                    self?.configureButtonPlay(wordsCell, with: word.soundUrl)
                    self?.configureButtonBookmark(wordsCell, with: result)
                }
            },
            // played, bookmarked
            Driver.merge(output.played, output.bookmarked).drive(onNext: { [weak self] result in
                result.onFailure(self?.rmController.handleError)
            }),
            // loading
            output.loading.drive(activityIndicator.rx.isAnimating)
        )
    }

    private func createSearchDriver() -> Driver<String> {
        let inputText = { [weak self] () -> String in
            guard let text = self?.searchController.searchBar.text else { return "" }
            return text
        }
        let dismissSearchController: ((String) -> Void) = { [weak self] value in
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
        if cell.buttonPlay.isHidden {
            return
        }
        cell.buttonPlay.rx.tap
            .compactMap { url }
            .bind(to: playUrl)
            .disposed(by: cell.disposeBag)
    }

    private func configureButtonBookmark(_ cell: WordsTableViewCell, with result: FoundWord) {
        cell.buttonBookmark.isSelected = result.bookmarked
        let tapped = cell.buttonBookmark.rx.tap
            .map { _ -> UIButton in
                cell.buttonBookmark.isSelected = !cell.buttonBookmark.isSelected
                return cell.buttonBookmark
            }.share()
        cell.disposeBag.insert(
            tapped.filter { $0.isSelected }
                .map { _ in result.word }
                .bind(to: addBookmark),
            tapped.filter { !$0.isSelected }
                .map { _ in result.word }
                .bind(to: removeBookmark)
        )
    }
}
