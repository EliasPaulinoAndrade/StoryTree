//
//  MockMessagesViewModel.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine
@testable import StoryTreeiOS

class MockMessagesViewModel: MessagesViewModel {
    struct Output: MessagesViewModelOutput {
        var messages: AnyPublisher<[PassageViewModel], Never>
    }
    
    struct Input: MessagesViewModelInput {
        var messages: AnyPublisher<[String], Never>
    }
    
    var messagesSubject = CurrentValueSubject<[String], Never>([])
    lazy var input: MessagesViewModelInput = Input(messages: messagesSubject.eraseToAnyPublisher())
    
    var messages: [String] = []
    var messageWasSent: ((String) -> Void)?
    
    var cancellableStore: [AnyCancellable] = []
    
    func showNewMessage(text: String = "test") {
        messages.append(text)
        messagesSubject.send(messages)
    }
    
    func transform(input: MessagesViewModelInput) -> MessagesViewModelOutput {
        Output(messages: input.messages.map { (messages) -> [MockBallonViewModel] in
            return messages.map { (message) -> MockBallonViewModel in
                return MockBallonViewModel(text: message)
            }
        }.eraseToAnyPublisher())
    }
}
