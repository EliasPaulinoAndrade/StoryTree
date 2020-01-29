//
//  ChatViewTests.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 29/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
@testable import StoryTreeiOS

class ChatViewTests: XCTestCase {
    func test_initialize_withCorrectSubviews() {
        let viewModel = MockChatViewmodel()
        let chatView = ChatView(viewModel: viewModel)
        
        XCTAssertEqual(chatView.messagesView.superview, chatView)
        XCTAssertEqual(chatView.messagesInputView.superview, chatView)
    }
    
    func test_inputViewModelButtonIsTapped_callsViewModelWithTheNewMessage() {
        let viewModel = MockChatViewmodel()
        let chatView = ChatView(viewModel: viewModel)
        
        
    }
}

