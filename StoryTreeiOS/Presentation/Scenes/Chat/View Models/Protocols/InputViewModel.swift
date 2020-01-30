//
//  InputViewModel.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 28/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine

protocol InputViewModelInput {
    var messageWasSent: AnySubject<String, Never> { get set }
    var choiceWasMade: AnySubject<String, Never> { get set }
    var choices: AnyPublisher<[String], Never> { get set }
}

protocol InputViewModelOutput {
    var message: AnyPublisher<String?, Never> { get set }
    var choices: AnyPublisher<[ChoiceViewModel], Never> { get set }
}

protocol InputViewModel {
    var input: InputViewModelInput { get set }
    
    func transform(input: InputViewModelInput) -> InputViewModelOutput
}

extension InputViewModel {
    var output: InputViewModelOutput {
        return transform(input: input)
    }
}
