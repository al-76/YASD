//
//  ClearCacheUseCaseTests.swift
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

class ClearCacheUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)
    
    func testExecute() {
        // Arrange
        let outputResult = scheduler.createObserver(CacheServiceBoolResult.self)
        let useCase = ClearCacheUseCase(cache: MockFactory.createMockCacheService(0))
        let res = useCase.execute(with: ())
        res.bind(to: outputResult)
            .disposed(by: disposeBag)

        // Act
        scheduler.start()

        // Assert
        XCTAssertEqual(outputResult.events, [
            .next(0, .success(true)),
            .completed(0)
        ])
    }
}
