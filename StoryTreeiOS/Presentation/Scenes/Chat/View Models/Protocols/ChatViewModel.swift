//
//  ChatViewModel.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

protocol ChatViewModelOutput {
    var numberOfMessages: () -> Int { get set }
    var ballonViewModelAt: (Int) -> PassageViewModel { get set }
    var showNewMessage: ((_ viewModel: PassageViewModel) -> Void)? { get set }
}

protocol ChatViewModel {
    var output: ChatViewModelOutput { get set }
}
