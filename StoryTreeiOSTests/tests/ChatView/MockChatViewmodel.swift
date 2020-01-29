//
//  MockChatViewmodel.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 29/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
@testable import StoryTreeiOS

private struct Output: ChatViewModel.ChatOutput {
    var inputViewModel: InputViewModel = MockInputViewModel()
    var messagesViewModel: MessagesViewModel = MockMessagesViewModel()
}

struct MockChatViewmodel: ChatViewModel {
    var output: ChatOutput = Output()
    
    func callInputButtonWasTapped() {
//        output.inputViewModel.o
    }
}
