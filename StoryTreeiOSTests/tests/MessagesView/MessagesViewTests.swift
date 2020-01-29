//
//  MessagesViewTests.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
@testable import StoryTreeiOS

class MessagesViewTests: XCTestCase {
    func test_setViewModelAndShowNewMessage_changesViewState() {
        let viewModel = MockMessagesViewModel()
        let sut = MessagesView(viewModel: viewModel)
        
        XCTAssertEqual(sut.numberOfShowedItems, 0)
        viewModel.showNewMessage()
        XCTAssertEqual(sut.numberOfShowedItems, 1)
    }

    func test_setViewModelAndShowNewMessageTwoTimes_changesViewStateTwoTimes() {
        let viewModel = MockMessagesViewModel()
        let chatView = MessagesView(viewModel: viewModel)

        XCTAssertEqual(chatView.numberOfShowedItems, 0)

        viewModel.showNewMessage()
        XCTAssertEqual(chatView.numberOfShowedItems, 1)

        viewModel.showNewMessage()
        XCTAssertEqual(chatView.numberOfShowedItems, 2)
    }

    func test_setViewModelAndShowMessage_showsCorrectBallonCellWithTheViewModel() {
        let viewModel = MockMessagesViewModel()
        let chatView = MessagesView(viewModel: viewModel)

        XCTAssertEqual(chatView.numberOfShowedItems, 0)
        viewModel.showNewMessage(text: "test")
        let ballonView = chatView.dataSource?.tableView(chatView, cellForRowAt: IndexPath(row: 0, section: 0)) as? BallonView
        
        XCTAssertNotNil(ballonView?.viewModel)
        XCTAssertNotNil(ballonView?.reuseIdentifier)
        XCTAssertEqual(ballonView?.descriptionLabel.text, "test")
    }

    func test_callBallonCellAtWithNoMessages_returnsNil() {
        let viewModel = MockMessagesViewModel()
        let chatView = MessagesView(viewModel: viewModel)

        XCTAssertNil(chatView.ballonCellAt(position: 0))
    }
}
