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
    var message: PassthroughSubject<String, Never> = .init()
}

class MockInputViewModel: InputViewModel {
    var input: InputViewModelInput = Input()
}
