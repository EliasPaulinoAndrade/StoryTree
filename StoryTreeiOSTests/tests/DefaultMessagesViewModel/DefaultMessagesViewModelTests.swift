//
//  DefaultMessagesViewModelTests.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
import StoryTree
import Combine
@testable import StoryTreeiOS

class DefaultMessagesViewModelTests: XCTestCase {
    var cancellablesStore: [AnyCancellable] = []
    
    override func tearDown() {
        cancellablesStore = []
    }
    
    func test_initializeWithOnePassage_callsMessagesSubject() {
        let sut = makeSUT(option: .onePassage)
        let newMessageExpectation = expectation(description: "new message arrived")
        let wantedViewModels: [[MockBallonViewModel]] = [[MockBallonViewModel(text: "rootText")]]

        checkPublisherSequence(publisher: sut.output.messages.asMockPassageViewModelsObserver, toBeEqualTo: wantedViewModels, storeIn: &cancellablesStore) {
            newMessageExpectation.fulfill()
        }
        
        wait(for: [newMessageExpectation], timeout: 1)
    }
    
    func test_initializeWithMultiplePassages_callsMessageAndChoices() {
        let sut = makeSUT(option: .multiplePassages)
        
        let newMessageExpectation = expectation(description: "new message arrived")
        let choicesExpectation = expectation(description: "choices arrived")
        
        let wantedChoices: [[String]] = [["choice1", "choice2"]]
        let wantedViewModels: [[MockBallonViewModel]] = [[MockBallonViewModel(text: "rootText")]]

        checkPublisherSequence(publisher: sut.output.messages.asMockPassageViewModelsObserver, toBeEqualTo: wantedViewModels, storeIn: &cancellablesStore) {
            newMessageExpectation.fulfill()
        }
        
        checkPublisherSequence(publisher: sut.output.choices, toBeEqualTo: wantedChoices, storeIn: &cancellablesStore) {
            choicesExpectation.fulfill()
        }
    
        wait(for: [newMessageExpectation, choicesExpectation], timeout: 1)
    }

    func test_callOptionWasChosed_callsMessage() {
        let sut = makeSUT(option: .multiplePassages)
        let newMessageExpectation = expectation(description: "new message arrived")
        let wantedViewModels: [[MockBallonViewModel]] = [
            [MockBallonViewModel(text: "rootText")],
            [MockBallonViewModel(text: "rootText"), MockBallonViewModel(text: "TextOfChoice1")]
        ]

        checkPublisherSequence(publisher: sut.output.messages.asMockPassageViewModelsObserver, toBeEqualTo: wantedViewModels, storeIn: &cancellablesStore) {
            newMessageExpectation.fulfill()
        }

        sut.output.choices.sink { choices in
            if choices.count > 0 {
                sut.input.choiceWasMade.send(choices[0])
            }
        }.store(in: &cancellablesStore)

        wait(for: [newMessageExpectation], timeout: 1)
    }
    
    func makeSUT(option: MockStoryTree.Option) -> DefaultMessagesViewModel {
        return DefaultMessagesViewModel(
            repository: MockRepository(option: option),
            ballonViewModelInjector: ballonViewModelInjector
        )
    }
}

extension CurrentValueSubject where Output == [PassageViewModel], Failure == Never {
    var asMockPassageViewModelsObserver: Publishers.CompactMap<CurrentValueSubject<[PassageViewModel], Never>, [MockBallonViewModel]> {
        return self.compactMap { (viewModels) -> [MockBallonViewModel]? in
            return viewModels as? [MockBallonViewModel]
        }
    }
}
