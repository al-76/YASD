//
//  AboutViewModelTests.swift
//  YASDTests
//
//  Created by Vyacheslav Konopkin on 06.05.2021.
//  Copyright © 2021 yac. All rights reserved.
//

@testable import YASD

import RxSwift
import RxCocoa
import RxTest
import XCTest
import Cuckoo

class AboutViewModelTests: XCTestCase {
    enum TestError: Error {
        case someError
    }
    
    let disposeBag = DisposeBag()
    let scheduler = TestScheduler(initialClock: 0)
    
    // Outputs
    lazy var outputText = scheduler.createObserver(NSAttributedString.self)
    
    func testGetText() {
        // Arrange
        let testString = NSAttributedString(string: "test")
        let viewModel = AboutViewModel(getText: CreateMockGetTextAboutUseCase(value: testString))
        let output = viewModel.transform(from: AboutViewModel.Input())
        output.text.drive(outputText)
            .disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputText.events, [
            .next(0, testString),
            .completed(0)
        ])
    }
    
    func testGetTextError() {
        // Arrange
        let testString = NSAttributedString(string: "error")
        let viewModel = AboutViewModel(getText: CreateMockGetTextAboutUseCase(value: testString))
        let output = viewModel.transform(from: AboutViewModel.Input())
        output.text.drive(outputText)
            .disposed(by: disposeBag)
        
        // Act
        scheduler.start()
        
        // Assert
        XCTAssertEqual(outputText.events, [
            .next(0, NSAttributedString()),
            .completed(0)
        ])
    }
    
    func CreateMockGetTextAboutUseCase(value: NSAttributedString) -> MockAnyUseCase<Void, NSAttributedString> {
        let mockGetText = MockAnyUseCase(wrapped: MockUseCase<Void, NSAttributedString>())
        stub(mockGetText) { stub in
            when(stub.execute(with: any())).then { _ in
                return Observable<NSAttributedString>.create { observable in
                    if value.string == "error" {
                        observable.on(.error(TestError.someError))
                    } else {
                        observable.on(.next(value))
                    }
                    observable.onCompleted()
                    return Disposables.create()
                }
            }
        }
        return mockGetText
    }
}
