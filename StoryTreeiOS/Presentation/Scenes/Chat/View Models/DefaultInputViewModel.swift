//
//  DefaultInputViewModel.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 28/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine

struct InputViewModelInputObject: InputViewModelInput {
    var choiceWasMade: AnySubject<String, Never> = .init(subject: PassthroughSubject())
    var messageWasSent: AnySubject<String, Never> = .init(subject: PassthroughSubject())
    var choices: AnyPublisher<[String], Never>
}

struct InputViewModelOutputObject: InputViewModelOutput {
    var message: AnyPublisher<String?, Never>
    var choices: AnyPublisher<[ChoiceViewModel], Never>
}

class DefaultInputViewModel: InputViewModel {
    typealias Input = InputViewModelInputObject
    typealias Output = InputViewModelOutputObject
    
    var input: InputViewModelInput
    
    private let choiceViewModelInjector: Injector<ChoiceViewModel, String>
    private var cancellableStore: [AnyCancellable] = []
    
    init(input: Input, choiceViewModelInjector: @escaping Injector<ChoiceViewModel, String>) {
        self.input = input
        self.choiceViewModelInjector = choiceViewModelInjector
    }
    
    func transform(input: InputViewModelInput) -> InputViewModelOutput {
        Output(
            message: transform(messaseWasSent: input.messageWasSent.eraseToAnyPublisher(),
                               choiceWasMade: input.choiceWasMade.eraseToAnyPublisher()),
            choices: transform(choices: input.choices)
        )
    }
    
    func transform(messaseWasSent: AnyPublisher<String, Never>,
                   choiceWasMade: AnyPublisher<String, Never>) -> AnyPublisher<String?, Never> {
        let deleteMessagePublisher = messaseWasSent.map {_ in String?(nil) }
        let addMessagePublisher = choiceWasMade.map ( String?.init )
        let messageObserver = Just(nil).merge(with: addMessagePublisher).merge(with: deleteMessagePublisher)
        
        return messageObserver.eraseToAnyPublisher()
    }
    
    func transform(choices: AnyPublisher<[String], Never>) -> AnyPublisher<[ChoiceViewModel], Never> {
        choices.map{ choices -> [ChoiceViewModel] in
            choices.map(self.choiceViewModelInjector)
        }.eraseToAnyPublisher()
    }
}
