//
//  DefaultChatViewModel.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 30/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine
import StoryTree

struct ChatSubViewModels: DefaultChatViewModel.SubViewModels {
    var inputViewModel: InputViewModel
    var messagesViewModel: MessagesViewModel
}

struct ChatOutput: DefaultChatViewModel.Output {
    
}

struct ChatInput: DefaultChatViewModel.Input {
    var passages: AnyPublisher<Passage, Never>
}

class DefaultChatViewModel: ChatViewModel {
    typealias InputViewModelInjector = Injector<InputViewModel, AnyPublisher<[String], Never>>
    typealias MessagesViewModelInjector = Injector<MessagesViewModel, AnyPublisher<[String], Never>>
    
    var input: Input
    private var inputViewModelInjector: InputViewModelInjector
    private var messagesViewModelInjector: MessagesViewModelInjector
    private var messagesHistory: [String] = []
    private var cancellableStore: [AnyCancellable] = []
    
    init(input: ChatInput,
         inputViewModelInjector: @escaping InputViewModelInjector,
         messagesViewModelInjector: @escaping MessagesViewModelInjector) {

        self.input = input
        self.inputViewModelInjector = inputViewModelInjector
        self.messagesViewModelInjector = messagesViewModelInjector
    }
    
    func transform(input: Input) -> (output: Output, subViewModels: SubViewModels) {
        let choices = input.passages.map { (passage) -> [String] in
            Array(passage.actions.keys.sorted())
        }.eraseToAnyPublisher()
        
        let messages = input.passages.map { [weak self] (passage) -> [String] in
            ifIsSafe(self) { (self) -> [String] in
                self.messagesHistory.append(passage.text)
                let messagesHistory = self.messagesHistory
                return messagesHistory
            }
        }.eraseToAnyPublisher()
        
        let inputViewModel = inputViewModelInjector(choices)
        
        input.passages.sink { [weak self] passage in
            ifIsSafe(self) { (self) in
                passage.goAhead(inputViewModel.output.messageWasSent, cancellable: &self.cancellableStore)
            }
        }.store(in: &cancellableStore)
        
        return (
            ChatOutput(),
            ChatSubViewModels(inputViewModel: inputViewModelInjector(choices), messagesViewModel: messagesViewModelInjector(messages))
        )
    }
}
