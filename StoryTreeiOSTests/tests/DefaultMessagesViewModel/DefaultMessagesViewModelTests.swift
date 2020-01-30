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

        checkPublisherSequence(publisher: sut.output.messages.castOutput(to: [MockBallonViewModel].self), toBeEqualTo: wantedViewModels, storeIn: &cancellablesStore) {
            newMessageExpectation.fulfill()
        }
        
        wait(for: [newMessageExpectation], timeout: 1)
    }
    
    func test_initializeWithMultiplePassages_callsMessage() {
        let sut = makeSUT(option: .multiplePassages)
        
        let newMessageExpectation = expectation(description: "new message arrived")
        
        let wantedViewModels: [[MockBallonViewModel]] = [[MockBallonViewModel(text: "rootText")]]

        checkPublisherSequence(publisher: sut.output.messages.castOutput(to: [MockBallonViewModel].self), toBeEqualTo: wantedViewModels, storeIn: &cancellablesStore) {
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

        checkPublisherSequence(publisher: sut.output.messages.castOutput(to: [MockBallonViewModel].self), toBeEqualTo: wantedViewModels, storeIn: &cancellablesStore) {
            newMessageExpectation.fulfill()
        }

        sutInput.send(["rootText", "TextOfChoice1"])

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
