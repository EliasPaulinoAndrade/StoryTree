//
//  ChatViewTests.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
@testable import StoryTreeiOS

class ChatViewTests: XCTestCase {
    func test_setViewModelAndShowNewMessage_changesViewState() {
        let viewModel = MockChatViewModel()
        let chatView = ChatView(viewModel: viewModel)
        
        XCTAssertEqual(chatView.numberOfShowedItems, 0)
        viewModel.showNewMessage(text: "teste")
        XCTAssertEqual(chatView.numberOfShowedItems, 1)
    }
    
    func test_setViewModelAndShowNewMessageTwoTimes_changesViewStateTwoTimes() {
        let viewModel = MockChatViewModel()
        let chatView = ChatView(viewModel: viewModel)

        XCTAssertEqual(chatView.numberOfShowedItems, 0)

        viewModel.showNewMessage(text: "teste")
        XCTAssertEqual(chatView.numberOfShowedItems, 1)

        viewModel.showNewMessage(text: "teste2")
        XCTAssertEqual(chatView.numberOfShowedItems, 2)
    }
    
    func test_setViewModelAndShowMessage_showsCorrectBallonCell() {
        let viewModel = MockChatViewModel()
        let chatView = ChatView(viewModel: viewModel)

        XCTAssertEqual(chatView.numberOfShowedItems, 0)
        viewModel.showNewMessage(text: "teste")
        let ballonView = chatView.tableView(chatView, cellForRowAt: IndexPath(row: 0, section: 0)) as? BallonView

        XCTAssertNotNil(ballonView)
        XCTAssertNotNil(ballonView?.viewModel)
        XCTAssertNotNil(ballonView?.reuseIdentifier)
        XCTAssertEqual(ballonView?.descriptionLabel.text, "teste")
    }
    
    func test_callBallonCellAtWithNoMessages_returnsNil() {
        let viewModel = MockChatViewModel()
        let chatView = ChatView(viewModel: viewModel)
        
        XCTAssertNil(chatView.ballonCellAt(position: 0))
    }
}

class MockChatViewModel: ChatViewModel {
    struct Output: ChatViewModelOutput {
        var ballonViewModelAt: (Int) -> PassageViewModel
        var numberOfMessages: () -> Int
        var showNewMessage: ((PassageViewModel) -> Void)?
    }
    
    lazy var output: ChatViewModelOutput = Output(
        ballonViewModelAt: { _ in
            return MockViewModel(text: "teste")
        }, numberOfMessages: { [weak self] in
            return self?.numberOfMessages ?? 0
        }
    )
    
    var numberOfMessages: Int = 0
    
    init() {
        
    }
    
    func showNewMessage(text: String) {
        numberOfMessages += 1
        self.output.showNewMessage?(MockViewModel(text: text))
    }
}
