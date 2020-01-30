//
//  MockInputViewModel.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 28/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine
@testable import StoryTreeiOS

struct Input: InputViewModelInput {
    var choiceWasMade: AnySubject<String, Never> = .init(subject: PassthroughSubject())
    var messageWasSent: AnySubject<String, Never> = .init(subject: PassthroughSubject())
    var choices: AnyPublisher<[String], Never>
}

private struct Output: InputViewModelOutput {
    var message: AnyPublisher<String?, Never> = .init(CurrentValueSubject(nil))
    var choices: AnyPublisher<[ChoiceViewModel], Never> = .init(CurrentValueSubject([]))
}

class MockInputViewModel: InputViewModel {
    var input: InputViewModelInput
    private var choicesSubject = CurrentValueSubject<[String], Never>([])
    var choiceWasMadeSubject = CurrentValueSubject<[String], Never>([])
    var cancellableStore: [AnyCancellable] = []
    
    init(input: Input = .init(choices: PassthroughSubject<[String], Never>().eraseToAnyPublisher())) {
        self.input = input
        input.choices.sink { [weak self] (choices) in
            self?.choiceWasMadeSubject.send(choices)
        }.store(in: &cancellableStore)
    }
    
    func changeChoices(to choices: [String]) {
        choicesSubject.send(choices)
    }
    
    func transform(input: InputViewModelInput) -> InputViewModelOutput {
    
        return Output()
    }
}
