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

private struct Input: InputViewModelInput {
    var messageWasSent: PassthroughSubject<String, Never> = .init()
}

private struct Output: InputViewModelOutput {
    var choices: CurrentValueSubject<[String], Never> = .init([])
    var message: CurrentValueSubject<String?, Never> = .init(nil)
}

class MockInputViewModel: InputViewModel {
    var input: InputViewModelInput = Input()
    var output: InputViewModelOutput = Output()
    
    func changeChoices(to choices: [String]) {
        output.choices.send(choices)
    }
}
