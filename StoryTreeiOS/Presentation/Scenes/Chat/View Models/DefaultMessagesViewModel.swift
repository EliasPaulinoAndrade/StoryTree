//
//  DefaultChatViewModel.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine
import StoryTree

private struct Output: MessagesViewModel.MessagesOutput {
    var choices: CurrentValueSubject<[String], Never> = .init([])
    var messages: CurrentValueSubject<[PassageViewModel], Never> = .init([])
}

class DefaultMessagesViewModel: MessagesViewModel {
    lazy var output: MessagesViewModel.MessagesOutput = Output()

    private var cancellables: [AnyCancellable] = []
    private let repository: StoryTreeRepository
    private let ballonViewModelInjector: Injector<PassageViewModel, String>
    private var passagesHistory: [Passage] = []
    
    init(repository: StoryTreeRepository,
         ballonViewModelInjector: @escaping Injector<PassageViewModel, String>) {

        self.repository = repository
        self.ballonViewModelInjector = ballonViewModelInjector
        
        getStory()
    }
    
    private func getStory() {
        repository.getTree { (result) in
            switch result {
            case .success(let story):
                formatInputAndOutput(forStory: story)
            case .failure:
                break
            }
        }
    }
    
    private func formatInputAndOutput(forStory story: StoryTree) {
        story.foreachAction { [weak self] passage in
            ifIsSafe(self) { (self) in
                self.passagesHistory.append(passage)
                self.output.messages.send(self.passagesHistory.map({ self.ballonViewModelInjector($0.text) }))
                self.output.choices.send(Array(passage.actions.keys.sorted()))
            }
        }
    }
}
