//
//  MockChatViewModel.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
@testable import StoryTreeiOS

class MockChatViewModel: ChatViewModel {
    struct Output: ChatViewModelOutput {
        var ballonViewModelAt: (Int) -> PassageViewModel
        var numberOfMessages: () -> Int
        var showNewMessage: ((PassageViewModel) -> Void)?
    }
    
    lazy var output: ChatViewModelOutput = Output(
        ballonViewModelAt: { _ in
            return MockBallonViewModel(text: "teste")
        }, numberOfMessages: { [weak self] in
            return self?.numberOfMessages ?? 0
        }
    )
    
    var numberOfMessages: Int = 0
    
    func showNewMessage(text: String) {
        numberOfMessages += 1
        self.output.showNewMessage?(MockBallonViewModel(text: text))
    }
}
