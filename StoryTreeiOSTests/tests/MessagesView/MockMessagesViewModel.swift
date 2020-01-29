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
        var inputViewModel: InputViewModel
        var messages: CurrentValueSubject<[PassageViewModel], Never> = .init([])
        var choices: CurrentValueSubject<[String], Never> = .init([])
    }
    
    lazy var output: MessagesViewModelOutput = Output(inputViewModel: MockInputViewModel())
    var messages: [String] = []
    var messageWasSent: ((String) -> Void)?
    
    var cancellableStore: [AnyCancellable] = []
    
    func showNewMessage(text: String = "test") {
        messages.append(text)
        self.output.messages.send(messages.map({ MockBallonViewModel(text: $0) }))
    }
}
