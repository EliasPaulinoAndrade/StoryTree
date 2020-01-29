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
    var message: PassthroughSubject<String, Never> = .init()
    
}

struct DefaultInputViewModel: InputViewModel {
    var input: InputViewModelInput = Input()
    
}
