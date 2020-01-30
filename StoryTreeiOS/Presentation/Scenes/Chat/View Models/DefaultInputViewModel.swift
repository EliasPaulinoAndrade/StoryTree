//
//  DefaultInputViewModel.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 28/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine

private struct Input: InputViewModelInput {
    var messageWasSent: PassthroughSubject<String, Never> = .init()
}

private struct Output: InputViewModelOutput {
    var message: CurrentValueSubject<String?, Never> = .init(nil)
    var choices: CurrentValueSubject<[String], Never> = .init([])
}

struct DefaultInputViewModel: InputViewModel {
    var input: InputViewModelInput = Input()
    var output: InputViewModelOutput = Output()
}
