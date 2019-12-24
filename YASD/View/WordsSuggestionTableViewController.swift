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
import RxDataSources

class WordsSuggestionTableViewController: UITableViewController {
    var model: WordsSuggestionViewModel!
    let disposeBag = DisposeBag()
    let search = PublishRelay<String>()
    let addHistory = PublishRelay<String>()
    let selectSuggestion = PublishRelay<String>()
    private let dataSource = createDataSource()

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
        let suggestion: ((IndexPath) -> String) = { [weak self] index in
            guard let self = self else { return "" }
            return self.suggestion(index)
        }
        let input = WordsSuggestionViewModel
            .Input(search: search.asDriver(onErrorJustReturn: ""),
                   addHistory: addHistory.asDriver(onErrorJustReturn: ""),
                   removeHistory: tableView.rx.itemDeleted.map { suggestion($0) }.asDriver(onErrorJustReturn: ""))
        let output = model.transform(from: input)
        disposeBag.insert(
            output.suggestions.map { [weak self] result -> [SuggestionItem] in
                    return result.handleResult([], self?.handleError)
            }
            .map { suggestions in [SuggestionItemSection(header: "suggestions", items: suggestions)] }
            .drive(tableView.rx.items(dataSource: dataSource)),
            tableView.rx.itemSelected
                .map { suggestion($0) }
                .bind(to: selectSuggestion)
        )
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

struct SuggestionItemSection {
    let header: String
    var items: [SuggestionItem]
}

extension SuggestionItem: IdentifiableType {
    var identity: String {
        return self.suggestion ?? ""
    }
}

extension SuggestionItem: Equatable {
    static public func == (lhs: SuggestionItem, rhs: SuggestionItem) -> Bool {
        return lhs.suggestion == rhs.suggestion && lhs.removable == rhs.removable
    }
}

extension SuggestionItemSection: AnimatableSectionModelType {
    typealias Item = SuggestionItem
    
    var identity: String { return self.header }
    
    init(original: SuggestionItemSection, items: [SuggestionItem]) {
        self = original
        self.items = items
    }
}

fileprivate func createDataSource() -> RxTableViewSectionedAnimatedDataSource<SuggestionItemSection> {
    return RxTableViewSectionedAnimatedDataSource(animationConfiguration: AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic),
                                                  configureCell: { (dataSource, tableView, indexPath, suggestion) -> UITableViewCell in
                                                    let id = "WordsSuggestionTableCell"
                                                    let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
                                                    if let suggestionCell = cell as? WordsSuggestionTableViewCell {
                                                        configureCell(suggestionCell, with: suggestion)
                                                    }
                                                    return cell
    },
                                                  canEditRowAtIndexPath: { dataSource, index in
                                                    return getSuggestionItem(from: dataSource, with: index).removable
    })
}

fileprivate func getSuggestionItem(from dataSource: TableViewSectionedDataSource<SuggestionItemSection>, with index: IndexPath) -> SuggestionItem {
    let section = dataSource.sectionModels[index.section]
    return section.items[index.row]
}

fileprivate func configureCell(_ cell: WordsSuggestionTableViewCell, with result: SuggestionItem) {
    cell.label.text = result.suggestion
    cell.setRemovable(result.removable)
    if !result.removable {
        return
    }
}
