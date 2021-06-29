//
//  ChangedBookmarkUseCaseTests.swift
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

class ChangedBookmarkUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)
    
    func testExecute() {
        // Arrange
        let testValue = "test"
        let outputItems = scheduler.createObserver(Bookmarks.self)
        let inputChangedBookmarks = scheduler.createHotObservable([
            .next(160, true)
        ])
        let changedBookmarks = PublishSubject<Bool>()
        let useCase = ChangedBookmarkUseCase(bookmarks: MockFactory.createFormattedWordStorageRepository(testValue, changedBookmarks),
                                             cache: MockFactory.createMockExternalCacheService("test"))
        let res = useCase.execute(with: ())
        disposeBag.insert(
            inputChangedBookmarks.bind(to: changedBookmarks),
            res.bind(to: outputItems)
        )
        
        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputItems.events, [
            .next(160, .success([FormattedWord(testValue)]))
        ])
    }
}
