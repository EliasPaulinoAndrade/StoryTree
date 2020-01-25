//
//  DefaultChatViewModel.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

class DefaultChatViewModel: ChatViewModel {
    struct Output: ChatViewModelOutput {
        var numberOfMessages: () -> Int
        
        var ballonViewModelAt: (Int) -> PassageViewModel
        
        var showNewMessage: ((PassageViewModel) -> Void)?
    }
    var output: ChatViewModelOutput = Output(numberOfMessages: { return 0}, ballonViewModelAt: {_ in return DefaultBallonViewModel(text: "")})
}
