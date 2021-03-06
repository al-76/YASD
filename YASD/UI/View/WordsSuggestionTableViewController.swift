//
//  WordsSuggestionTableViewController.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 10.10.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RMessage
import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class WordsSuggestionTableViewController: UITableViewController {
    var viewModel: WordsSuggestionViewModel!
    let disposeBag = DisposeBag()
    let search = PublishRelay<String>()
    let addHistory = PublishRelay<String>()
    let selectSuggestion = PublishRelay<String>()
    private let dataSource = createDataSource()
    private let rmController = RMController()

    override func viewDidLoad() {
        super.viewDidLoad()

        rmController.presentationViewController = self
        customizeView()
        bindToModel()
    }

    private func customizeView() {
        clearsSelectionOnViewWillAppear = false

        tableView.dataSource = nil
        tableView.delegate = nil
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
        let output = viewModel.transform(from: input)
        disposeBag.insert(
            // suggestions
            output.suggestions.map { [weak self] result -> [SuggestionItem] in
                result.onFailure(self?.rmController.handleError)
                    .getOrDefault([])
            }
            .map { suggestions in [SuggestionItemSection(header: "suggestions", items: suggestions)] }
            .drive(tableView.rx.items(dataSource: dataSource)),
            // item selected
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
}

struct SuggestionItemSection {
    let header: String
    var items: [SuggestionItem]
}

extension SuggestionItem: IdentifiableType {
    var identity: String {
        return suggestion ?? ""
    }
}

extension SuggestionItem: Equatable {
    public static func == (lhs: SuggestionItem, rhs: SuggestionItem) -> Bool {
        return lhs.suggestion == rhs.suggestion && lhs.removable == rhs.removable
    }
}

extension SuggestionItemSection: AnimatableSectionModelType {
    typealias Item = SuggestionItem

    var identity: String { return header }

    init(original: SuggestionItemSection, items: [SuggestionItem]) {
        self = original
        self.items = items
    }
}

private func createDataSource() -> RxTableViewSectionedAnimatedDataSource<SuggestionItemSection> {
    return RxTableViewSectionedAnimatedDataSource(animationConfiguration:
        AnimationConfiguration(insertAnimation: .automatic,
                               reloadAnimation: .automatic,
                               deleteAnimation: .automatic),
        configureCell: { _, tableView, _, suggestion -> UITableViewCell in
            let id = "WordsSuggestionTableCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: id) ??
                UITableViewCell(style: .default, reuseIdentifier: id)
            if let suggestionCell = cell as? WordsSuggestionTableViewCell {
                configureCell(suggestionCell, with: suggestion)
            }
            return cell
        },
        canEditRowAtIndexPath: { dataSource, index in
            getSuggestionItem(from: dataSource, with: index).removable
        })
}

private func getSuggestionItem(from dataSource: TableViewSectionedDataSource<SuggestionItemSection>,
                               with index: IndexPath) -> SuggestionItem {
    let section = dataSource.sectionModels[index.section]
    return section.items[index.row]
}

private func configureCell(_ cell: WordsSuggestionTableViewCell, with result: SuggestionItem) {
    cell.label.text = result.suggestion
    cell.setRemovable(result.removable)
}
