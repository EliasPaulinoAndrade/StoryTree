//
//  ChatViewModel.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 29/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

protocol ChatViewModelOutput {
    var inputViewModel: InputViewModel { get }
    var messagesViewModel: MessagesViewModel { get }
}

protocol ChatViewModel {
    typealias ChatOutput = ChatViewModelOutput
    var output: ChatOutput { get set }
}
