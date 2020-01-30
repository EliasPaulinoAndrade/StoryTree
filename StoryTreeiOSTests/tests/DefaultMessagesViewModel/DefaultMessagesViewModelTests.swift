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
    
    func test_initializeWithMultiplePassages_callsMessage() {
        let sut = makeSUT(option: .multiplePassages)
        
        let newMessageExpectation = expectation(description: "new message arrived")
        
        let wantedViewModels: [[MockBallonViewModel]] = [[MockBallonViewModel(text: "rootText")]]

        checkPublisherSequence(publisher: sut.output.messages.asMockPassageViewModelsObserver, toBeEqualTo: wantedViewModels, storeIn: &cancellablesStore) {
            newMessageExpectation.fulfill()
        }

        wait(for: [newMessageExpectation], timeout: 1)
    }

    func test_inputMessageChange_callsMessage() {
        let sutInput = CurrentValueSubject<[String], Never>(["rootText"])
        let sut = makeSUT(option: .multiplePassages, input: sutInput.eraseToAnyPublisher())
        let newMessageExpectation = expectation(description: "new message arrived")
        let wantedViewModels: [[MockBallonViewModel]] = [
            [MockBallonViewModel(text: "rootText")],
            [MockBallonViewModel(text: "rootText"), MockBallonViewModel(text: "TextOfChoice1")]
        ]

        checkPublisherSequence(publisher: sut.output.messages.asMockPassageViewModelsObserver, toBeEqualTo: wantedViewModels, storeIn: &cancellablesStore) {
            newMessageExpectation.fulfill()
        }

        sutInput.send(["rootText", "TextOfChoice1"])
//        sut.output.choices.sink { choices in
//            if choices.count > 0 {
//                sut.input.choiceWasMade.send(choices[0])
//            }
//        }.store(in: &cancellablesStore)

        wait(for: [newMessageExpectation], timeout: 1)
    }
    
    func makeSUT(
        option: MockStoryTree.Option,
        input: AnyPublisher<[String], Never> = Just(["rootText"]).eraseToAnyPublisher()) -> DefaultMessagesViewModel {
        
        return DefaultMessagesViewModel(
            input: DefaultMessagesViewModel.Input(messages: input),
            ballonViewModelInjector: ballonViewModelInjector
        )
    }
}

extension Publisher where Output == [PassageViewModel], Failure == Never {
    var asMockPassageViewModelsObserver: AnyPublisher<[MockBallonViewModel], Never> {
        return self.compactMap { (viewModels) -> [MockBallonViewModel]? in
            return viewModels as? [MockBallonViewModel]
        }.eraseToAnyPublisher()
    }
}
