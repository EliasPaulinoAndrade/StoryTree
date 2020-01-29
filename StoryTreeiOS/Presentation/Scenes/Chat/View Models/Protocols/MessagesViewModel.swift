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
    var messages: CurrentValueSubject<[PassageViewModel], Never> { get set }
    var choices: CurrentValueSubject<[String], Never> { get set }
}

protocol MessagesViewModel {
    typealias MessagesOutput = MessagesViewModelOutput
    
    var output: MessagesOutput { get set }
}
