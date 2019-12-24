//
//  BookmarksTableViewController.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 24.12.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class BookmarksTableViewController: UITableViewController {
    var model: BookmarksViewModel!
    
    private let disposeBag = DisposeBag()
    private let playUrl = PublishRelay<String>()
    private let removeBookmark = PublishRelay<Int>()
    private let searchTemp = BehaviorRelay<String>(value: "")
//    private var searchController: UISearchController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchTemp.accept("") // update
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeView()
        bindToModel()
    }
    
    private func customizeView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
    
    private func bindToModel() {
        let dataSource = createDataSource({ [weak self] cell, word in
            guard let self = self else { return }
            cell.textView.attributedText = word.formatted
            cell.buttonPlay.rx.tap
                .compactMap { word.soundUrl }
                .bind(to: self.playUrl)
                .disposed(by: self.disposeBag)
        })
        let input = BookmarksViewModel.Input(search: searchTemp.asDriver(),
                                             playUrl: playUrl.asDriver(onErrorJustReturn: ""),
                                             removeBookmark: removeBookmark.asDriver(onErrorJustReturn: -1))
        let output = model.transform(from: input)
        disposeBag.insert(
            output.bookmarks.map { [weak self] result -> [FormattedWord] in
                return result.handleResult([], self?.handleError)
            }
            .map { bookmarks in [BookmarkItemSection(header: "bookmarks", items: bookmarks)] }
            .drive(tableView.rx.items(dataSource: dataSource)),
            output.played.drive(onNext: { [weak self] result in
                _ = result.handleResult(false, self?.handleError)
            }),
            tableView.rx.itemDeleted
                .map { $0.row }
                .bind(to: removeBookmark)
        )
    }
    
    private func handleError(_ error: Error) {
        print(error) // TODO: show alert
    }
}

struct BookmarkItemSection {
    let header: String
    var items: [FormattedWord]
}

extension FormattedWord: IdentifiableType {
    var identity: NSAttributedString {
        return self.formatted
    }
}

extension BookmarkItemSection: AnimatableSectionModelType {
    typealias Item = FormattedWord
    
    var identity: String { return self.header }
    
    init(original: BookmarkItemSection, items: [FormattedWord]) {
        self = original
        self.items = items
    }
}

fileprivate func createDataSource(_ configureCell: @escaping (BookmarksTableViewCell, FormattedWord) -> Void) -> RxTableViewSectionedAnimatedDataSource<BookmarkItemSection> {
    return RxTableViewSectionedAnimatedDataSource(animationConfiguration: AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic),
                                                  configureCell: { (dataSource, tableView, indexPath, word) -> UITableViewCell in
                                                    let id = "BookmarksTableCell"
                                                    let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
                                                    if let bookmarkCell = cell as? BookmarksTableViewCell {
                                                        configureCell(bookmarkCell, word)
                                                    }
                                                    return cell
    },
                                                  canEditRowAtIndexPath: { dataSource, index in
                                                    return true
    })
}