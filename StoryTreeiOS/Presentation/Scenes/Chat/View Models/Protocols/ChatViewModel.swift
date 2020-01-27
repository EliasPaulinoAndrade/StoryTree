//
//  ChatViewModel.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine

protocol ChatViewModelOutput {
    var numberOfMessages: Int { get set }
    var ballonViewModelAt: (Int) -> PassageViewModel { get set }
    var showNewMessage: ((_ viewModel: PassageViewModel) -> Void)? { get set }
    var lastMessage: CurrentValueSubject<String?, Never> { get set }
    var choices: CurrentValueSubject<[String], Never> { get set }
}

protocol ChatViewModelInput {
    var choiceWasMade: PassthroughSubject<String, Never> { get set }
}

protocol ChatViewModel {
    var output: ChatViewModelOutput { get set }
    var input: ChatViewModelInput { get set }
}
