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
    
    var messagesSubject: CurrentValueSubject<[String], Never>
    var messagesInputSubject: CurrentValueSubject<[String], Never> = .init([])
    var input: MessagesViewModelInput
    
    var messages: [String] = []
    
    var cancellableStore: [AnyCancellable] = []
    
    init(input: Input? = nil) {
        let messagesSubject = CurrentValueSubject<[String], Never>([])
        self.messagesSubject = messagesSubject
        
        self.input = input ?? Input(messages: messagesSubject.eraseToAnyPublisher())
        self.input.messages.sink { [weak self] (messages) in
            self?.messagesInputSubject.send(messages)
        }.store(in: &cancellableStore)
    }
    
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
