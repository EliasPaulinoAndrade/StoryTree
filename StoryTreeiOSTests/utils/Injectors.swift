//
//  BallonViewModelInjector.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 26/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine
import StoryTree
@testable import StoryTreeiOS

func ballonViewModelInjector(_ text: String) -> PassageViewModel {
    return MockBallonViewModel(text: text)
}

func messagesViewModelInjector(_ messages: AnyPublisher<[String], Never>) -> MessagesViewModel {
    return MockMessagesViewModel(input: MockMessagesViewModel.Input(messages: messages))
}

func inputViewModelInjector(_ choices: AnyPublisher<[String], Never>) -> InputViewModel {
    return MockInputViewModel(input: Input(choices: choices))
}

func choiceViewModelInjector(_ text: String) -> ChoiceViewModel {
    return MockChoiceViewModel(choice: text)
}
