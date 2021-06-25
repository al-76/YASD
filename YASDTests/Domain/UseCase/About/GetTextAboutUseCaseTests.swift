//
//  GetTextAboutUseCaseTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 17.06.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import XCTest
import RxSwift
import RxCocoa
import RxTest
import Cuckoo

class GetTextAboutUseCaseTests: XCTestCase {
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)
    
    func testExecute() {
        // Arrange
        let testValue = "test"
        let outputText = scheduler.createObserver(NSAttributedString.self)
        let useCase = GetTextAboutUseCase(repository: createMockAboutTextRepository(testValue))
        let res = useCase.execute(with: ())
        res.bind(to: outputText)
            .disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputText.events, [
            .next(0, NSAttributedString(string: testValue)),
            .completed(0)
        ])
    }
    
    private func createMockAboutTextRepository(_ value: String) -> MockAboutTextRepository {
        let mock = MockAboutTextRepository()
        stub(mock) { stub in
            when(stub.getText()).then { _ in
                return .just(NSAttributedString(string: value))
            }
        }
        return mock
    }
}
