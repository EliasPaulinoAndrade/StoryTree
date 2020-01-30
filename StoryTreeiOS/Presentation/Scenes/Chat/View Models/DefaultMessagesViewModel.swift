//
//  DefaultChatViewModel.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine
import StoryTree

struct MessagesOutput: MessagesViewModel.MessagesOutput {
    var messages: AnyPublisher<[PassageViewModel], Never>
}

struct MessagesInput: MessagesViewModel.MessagesInput {
    var messages: AnyPublisher<[String], Never>
}

class DefaultMessagesViewModel: MessagesViewModel {
    typealias Input = MessagesInput
    typealias Output = MessagesOutput
    
    var input: MessagesViewModel.MessagesInput

    private var cancellables: [AnyCancellable] = []
    private let ballonViewModelInjector: Injector<PassageViewModel, String>
    
    init(input: Input, ballonViewModelInjector: @escaping Injector<PassageViewModel, String>) {
        self.input = input
        self.ballonViewModelInjector = ballonViewModelInjector
    }
    
    func transform(input: MessagesViewModel.MessagesInput) -> MessagesViewModel.MessagesOutput {
        return Output(messages: input.messages.map { (messages) -> [PassageViewModel] in
            return messages.map(self.ballonViewModelInjector)
        }.eraseToAnyPublisher())
    }
}
