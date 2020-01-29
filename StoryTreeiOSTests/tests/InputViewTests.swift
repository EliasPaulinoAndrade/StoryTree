//
//  InputViewTests.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 29/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
import Combine
@testable import StoryTreeiOS

class InputViewTests: XCTestCase {
    var cancellablesStore: [AnyCancellable] = []
    
    func test_initialize_withCorrectSubviews() {
        let viewModel = MockInputViewModel()
        let sut = InputView(viewModel: viewModel)
        
        XCTAssertEqual(sut.inputButton.superview, sut)
        XCTAssertEqual(sut.inputLabel.superview, sut)
    }
    
    func test_buttonTap_callInputWithMessage() {
        let viewModel = MockInputViewModel()
        let sut = InputView(viewModel: viewModel)
        let messageExpecation = expectation(description: "message is sent when the button is tapped")
        
        viewModel.input.message.sink { message in
            messageExpecation.fulfill()
        }.store(in: &cancellablesStore)
        
        sut.inputLabel.text = "newMessage"
        sut.inputButton.sendActions(for: .touchUpInside)
        
        wait(for: [messageExpecation], timeout: 1)
    }
    
    func test_buttonTapWithoutText_dontCallInputWithMessage() {
        let viewModel = MockInputViewModel()
        let sut = InputView(viewModel: viewModel)
        
        viewModel.input.message.sink { message in
            XCTAssertTrue(false)
        }.store(in: &cancellablesStore)
        
        sut.inputLabel.text = nil
        sut.inputButton.sendActions(for: .touchUpInside)
    }
}
