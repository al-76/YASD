//
//  BookmarksTableViewController.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 24.12.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit
import CoreSpotlight
import RxSwift
import RxCocoa
import RxDataSources
import RMessage

class BookmarksTableViewController: UITableViewController {
    var viewModel: BookmarksViewModel!
    
    private let disposeBag = DisposeBag()
    private let playUrl = PublishRelay<String>()
    private let removeBookmark = PublishRelay<Int>()
    private let restore = BehaviorRelay<String>(value: "")
    private var searchController: UISearchController!
    private let rmController = RMController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rmController.presentationViewController = self
        customizeView()
        bindToModel()
    }
    
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        if activity.activityType != CSSearchableItemActionType {
            return
        }
        guard let id = activity.userInfo? [CSSearchableItemActivityIdentifier] as? String else { return }
        restore.accept(id)
    }
    
    private func customizeView() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = NSLocalizedString("searchBar", comment: "")
        searchController.obscuresBackgroundDuringPresentation = false
        
        tableView.dataSource = nil
        tableView.delegate = nil
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        navigationItem.searchController = searchController
        navigationItem.hidesBackButton = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func bindToModel() {
        let dataSource = createDataSource({ [weak self] cell, word in
            guard let self = self else { return }
            cell.textView.attributedText = word.formatted
            cell.buttonPlay.isHidden = (word.soundUrl == nil)
            if cell.buttonPlay.isHidden {
                return
            }
            cell.buttonPlay.rx.tap
                .compactMap { word.soundUrl }
                .bind(to: self.playUrl)
                .disposed(by: cell.disposeBag)
        })
        let searchWord = searchController.searchBar.rx.text
            .distinctUntilChanged()
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: "")
        let input = BookmarksViewModel.Input(search: searchWord,
                                             playUrl: playUrl.asDriver(onErrorJustReturn: ""),
                                             removeBookmark: removeBookmark.asDriver(onErrorJustReturn: -1),
                                             restore: restore.asDriver(onErrorJustReturn: ""))
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            // bookmarks
            output.bookmarks.map { [weak self] result -> [FormattedWord] in
                return result.onFailure { self?.handleError($0) }.getOrDefault([])
            }
            .map { bookmarks in [BookmarkItemSection(header: "bookmarks", items: bookmarks)] }
            .drive(tableView.rx.items(dataSource: dataSource)),
            // played
            output.played.drive(onNext: { [weak self] result in
                result.onFailure { self?.handleError($0) }
            }),
            // search restored item
            output.restored.drive(searchController.searchBar.rx.text),
            // deleted item
            tableView.rx.itemDeleted
                .map { $0.row }
                .bind(to: removeBookmark)
        )
    }
    
    private func handleError(_ error: Error) {
        rmController.showMessage(withSpec: errorSpec,
                                 title: "Error",
                                 body: error.localizedDescription)
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
