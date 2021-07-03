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
        let outputText = createGetTextObserver(testString)
        
        // Act
        scheduler.start()
                
        // Assert
        XCTAssertEqual(outputText.events, [
            .next(0, .success(testString)),
            .completed(0)
        ])
    }
    
    func testGetTextError() {
        // Arrange
        let outputText = createGetTextObserver(NSAttributedString(string: "error"))
        
        // Act
        scheduler.start()
                
        // Assert
        XCTAssertEqual(outputText.events, [
            .next(0, .failure(TestError.someError)),
            .completed(0)
        ])
    }
    
    private func createGetTextObserver(_ testString: NSAttributedString) -> TestableObserver<AboutTextRepositoryResult> {
        let outputText = scheduler.createObserver(AboutTextRepositoryResult.self)
        let viewModel = AboutViewModel(getText: createMockGetTextAboutUseCase(value: testString))
        let output = viewModel.transform(from: AboutViewModel.Input())
        output.text.drive(outputText)
            .disposed(by: disposeBag)
        return outputText
    }
    
    private func createMockGetTextAboutUseCase(value: NSAttributedString) -> MockAnyUseCase<Void, AboutTextRepositoryResult> {
        return MockFactory.createMockUseCase { _ in
            value.string == "error" ? TestError.someError : nil
        } onRxError: { _ in
            nil
        } onSuccess: { _ in
            .success(value)
        }
    }
}
