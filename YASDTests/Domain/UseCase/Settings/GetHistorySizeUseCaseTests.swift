//
//  GetHistorySizeUseCaseTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 01.07.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import Cuckoo
import RxCocoa
import RxSwift
import RxTest
import XCTest

class GetHistorySizeUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)

    func testExecute() {
        // Arrange
        let testSize: Int64 = 1024
        let outputSize = scheduler.createObserver(String.self)
        let useCase = GetStorageSizeUseCase(history: MockFactory.createSuggestionStorageRepository("", testSize))
        let res = useCase.execute(with: ())
        res.bind(to: outputSize)
            .disposed(by: disposeBag)

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputSize.events, [
            .next(0, ByteCountFormatter.string(fromByteCount: testSize,
                                               countStyle: .file)), // FIXME: Hidden dependency
            .completed(0)
        ])
    }
}
