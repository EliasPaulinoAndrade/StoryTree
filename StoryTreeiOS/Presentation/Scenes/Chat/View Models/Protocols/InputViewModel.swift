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
    var messageWasSent: PassthroughSubject<String, Never> { get set }
}

protocol InputViewModelOutput {
    var message: CurrentValueSubject<String?, Never> { get set }
    var choices: CurrentValueSubject<[String], Never> { get set }
}

protocol InputViewModel {
    var input: InputViewModelInput { get set }
    var output: InputViewModelOutput { get set }
}
