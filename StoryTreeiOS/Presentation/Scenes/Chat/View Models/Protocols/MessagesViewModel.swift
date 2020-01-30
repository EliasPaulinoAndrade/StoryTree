//
//  MessagesViewModel.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine

protocol MessagesViewModelOutput {
    var messages: AnyPublisher<[PassageViewModel], Never> { get set }
}

protocol MessagesViewModelInput {
    var messages: AnyPublisher<[String], Never> { get set }
}

protocol MessagesViewModel {
    typealias MessagesOutput = MessagesViewModelOutput
    typealias MessagesInput = MessagesViewModelInput
    
    var input: MessagesInput { get set }
    
    func transform(input: MessagesInput) -> MessagesOutput
}

extension MessagesViewModel {
    var output: MessagesOutput {
        return self.transform(input: self.input)
    }
}
