//
//  MockChatViewmodel.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 29/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine
import StoryTree
@testable import StoryTreeiOS

private struct ChatOutput: ChatViewModelOutput {
    
}

private struct ChatSubViewModels: ChatViewModelSubViewModels {
    var inputViewModel: InputViewModel = MockInputViewModel()
    var messagesViewModel: MessagesViewModel = MockMessagesViewModel()
}

private struct ChatInput: ChatViewModelInput {
    var passages: AnyPublisher<Passage, Never> = PassthroughSubject<Passage, Never>().eraseToAnyPublisher()
}

struct MockChatViewmodel: ChatViewModel {
    var input: Self.Input = ChatInput()
        
    func callInputButtonWasTapped() {
//        output.inputViewModel.o
    }
    
    func transform(input: Self.Input) -> (output: Self.Output, subViewModels: Self.SubViewModels) {
        return (
            ChatOutput(),
            ChatSubViewModels()
        )
    }
}
