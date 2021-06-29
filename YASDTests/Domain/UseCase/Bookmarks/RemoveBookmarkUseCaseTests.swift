//
//  RemoveBookmarkUseCaseTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 29.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Cuckoo

class RemoveBookmarkUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    func testExecute() {
        // Arrange
        let outputItems = scheduler.createObserver(StorageServiceResult.self)
        let useCase = RemoveBookmarkUseCase(bookmarks: MockFactory.createFormattedWordStorageRepository("test"))
        let res = useCase.execute(with: FormattedWord("test"))
        disposeBag.insert(
            res.bind(to: outputItems)
        )
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputItems.events, [
            .next(0, .success(true)),
            .completed(0)
        ])
    }
}
