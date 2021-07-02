//
//  ClearHistoryUseCaseTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 01.07.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Cuckoo

class ClearHistoryUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)
    
    func testExecute() {
        // Arrange
        let outputSize = scheduler.createObserver(StorageServiceResult.self)
        let useCase = ClearHistoryUseCase(history: MockFactory.createSuggestionStorageRepository("", 0))
        let res = useCase.execute(with: ())
        res.bind(to: outputSize)
            .disposed(by: disposeBag)

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputSize.events, [
            .next(0, .success(true)),
            .completed(0)
        ])
    }
}
