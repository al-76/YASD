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
    let search = BehaviorRelay<String>(value: "")
    let addHistory = BehaviorRelay<String>(value: "")
    let selectSuggestion = BehaviorRelay<String>(value: "")
    let removeHistory = BehaviorRelay<String>(value: "")
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
        let input = WordsSuggestionViewModel.Input(search: search.asDriver(), addHistory: addHistory.asDriver(), removeHistory: removeHistory.asDriver())
        model.transform(from: input).suggestions
        .map { [weak self] result -> [SuggestionItem] in
            return result.handleResult([], self?.handleError)
        }
        .map { suggestions in [SuggestionItemSection(header: "suggestions", items: suggestions)] }
        .drive(tableView.rx.items(dataSource: dataSource))
        .disposed(by: self.disposeBag)
           
        
        let suggestion: ((IndexPath) -> String) = { [weak self] index in
            guard let self = self else { return "" }
            return self.suggestion(index)
        }
        tableView.rx.itemSelected
            .map { suggestion($0) }
            .bind(to: selectSuggestion)
            .disposed(by: disposeBag)
        tableView.rx.itemDeleted
            .map { suggestion($0) }
            .bind(to: removeHistory)
            .disposed(by: disposeBag)
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
                                                        configureCell(suggestionCell, with: getSuggestionItem(from: dataSource, with: indexPath))
//                                                        suggestionCell.setRemovable(getSuggestionItem(from: dataSource, with: indexPath).removable)
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
