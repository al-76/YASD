//
//  RemoveBookmarkByIndexUseCaseTests.swift
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

class RemoveBookmarkByIndexUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    func testExecute() {
        // Arrange
        let outputItems = scheduler.createObserver(StorageServiceResult.self)
        let useCase = RemoveBookmarkByIndexUseCase(bookmarks: MockFactory.createFormattedWordStorageRepository("test"))
        let res = useCase.execute(with: 0)
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
