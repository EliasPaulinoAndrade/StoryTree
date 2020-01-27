//
//  ChatViewControllerTests.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 26/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
@testable import StoryTreeiOS

class ChatViewControllerTests: XCTestCase {
    func test_initilization_mustAddChatViewAsChild() {
        let sut = ChatViewController(viewModel: MockChatViewModel())
            
        XCTAssertEqual(sut.chatView.superview, sut.view)
    }
}
