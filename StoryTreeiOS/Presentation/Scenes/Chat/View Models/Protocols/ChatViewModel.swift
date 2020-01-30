//
//  ChatViewModel.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 29/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine
import StoryTree

protocol ChatViewModelOutput {
    
}

protocol ChatViewModelInput {
    var passages: AnyPublisher<Passage, Never> { get }
}

protocol ChatViewModelSubViewModels {
    var inputViewModel: InputViewModel { get }
    var messagesViewModel: MessagesViewModel { get }
}

protocol ChatViewModel {
    typealias SubViewModels = ChatViewModelSubViewModels
    typealias Output = ChatViewModelOutput
    typealias Input = ChatViewModelInput
    
    var input: Input { get set }
    
    func transform(input: Input) -> (output: Output, subViewModels: SubViewModels)
}

extension ChatViewModel {
    var subViewModels: SubViewModels {
        return transform(input: input).subViewModels
    }
    
    var output: ChatViewModelOutput {
        return transform(input: input).output
    }
}
