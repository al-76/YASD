//
//  RestoreBookmarksUseCaseTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 25.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Cuckoo

class RestoreBookmarksUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)
    
    func testExecute() {
        // Arrange
        let testValue = "test"
        let outputResult = scheduler.createObserver(String.self)
        let useCase = RestoreBookmarkUseCase(cache: createMockExternalCacheService(testValue))
        let res = useCase.execute(with: "")
        res.bind(to: outputResult)
            .disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputResult.events, [
            .next(0, testValue),
            .completed(0)
        ])
    }
    
    private func createMockExternalCacheService(_ testValue: String) -> MockExternalCacheService {
        let mock = MockExternalCacheService()
        stub(mock) { stub in
            when(stub.getTitle(from: any())).then { _ in
                return testValue
            }
        }
        return mock
    }
}
