//
//  SearchBookmarksUseCaseTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 25.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import Cuckoo
import RxCocoa
import RxSwift
import RxTest
import XCTest

class SearchBookmarksUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    func testExecute() {
        // Arrange
        let testValue = "test"
        let outputItems = scheduler.createObserver(Bookmarks.self)
        let useCase = SearchBookmarkUseCase(bookmarks: MockFactory
                                                .createFormattedWordStorageRepository(testValue,
                                                                                      PublishSubject<Bool>()))
        let res = useCase.execute(with: "")
        disposeBag.insert(
            res.bind(to: outputItems)
        )

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputItems.events, [
            .next(0, .success([FormattedWord(testValue)])),
            .completed(0)
        ])
    }
}
