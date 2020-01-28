//
//  MockChatViewModel.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine
@testable import StoryTreeiOS

class MockChatViewModel: ChatViewModel {
    struct Output: ChatViewModelOutput {
        var messageWasAdded: CurrentValueSubject<Void, Never> = .init(())
        var choices: CurrentValueSubject<[String], Never> = .init([])
        var numberOfMessages: Int = 0
        var ballonViewModelAt: (Int) -> PassageViewModel
    }
    
    struct Input: ChatViewModelInput {
        var choiceWasMade: PassthroughSubject<String, Never>
    }
    
    lazy var output: ChatViewModelOutput = Output(ballonViewModelAt: { _ in return MockBallonViewModel(text: "teste")})
    var input: ChatViewModelInput = Input(choiceWasMade: .init())
        
    func showNewMessage(text: String) {
        output.numberOfMessages += 1
        self.output.messageWasAdded.send()
    }
}
