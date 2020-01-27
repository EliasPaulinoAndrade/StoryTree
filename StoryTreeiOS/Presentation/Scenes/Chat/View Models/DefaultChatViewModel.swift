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

private struct Output: ChatViewModelOutput {
    var choices: CurrentValueSubject<[String], Never> = .init([])
    var lastMessage: CurrentValueSubject<String?, Never> = .init(nil)
    var numberOfMessages: Int = 0
    var ballonViewModelAt: (Int) -> PassageViewModel
    var showNewMessage: ((PassageViewModel) -> Void)?
}

private struct Input: ChatViewModelInput {
    var choiceWasMade: PassthroughSubject<String, Never> = .init()
}

class DefaultChatViewModel: ChatViewModel {
    lazy var output: ChatViewModelOutput = Output(ballonViewModelAt: ballonViewModelAt)
    lazy var input: ChatViewModelInput = Input()

    private var cancellables: [AnyCancellable] = []
    private let repository: StoryTreeRepository
    private let ballonViewModelInjector: Injector<PassageViewModel, String>
    private var passagesHistory: [Passage] = []
    
    init(repository: StoryTreeRepository, ballonViewModelInjector: @escaping Injector<PassageViewModel, String>) {
        self.repository = repository
        self.ballonViewModelInjector = ballonViewModelInjector
        getStory()
    }
    
    private func ballonViewModelAt(position: Int) -> PassageViewModel {
        return ballonViewModelInjector(passagesHistory[position].text)
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
                self.output.numberOfMessages += 1
                self.passagesHistory.append(passage)
                self.output.lastMessage.send(passage.text)
                self.output.choices.send(Array(passage.actions.keys.sorted()))
            }
        }

        input.choiceWasMade.sink { choice in
            story.goAhead(action: choice)
        }.store(in: &self.cancellables)
    }
}
