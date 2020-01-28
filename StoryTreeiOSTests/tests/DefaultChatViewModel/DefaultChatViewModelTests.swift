//
//  DefaultChatViewModelTests.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
import StoryTree
import Combine
@testable import StoryTreeiOS

class DefaultChatViewModelTests: XCTestCase {
    var cancellablesStore: [AnyCancellable] = []
    
    override func tearDown() {
        cancellablesStore = []
    }
    
    func test_initializeWithOnePassage_callsShowNewMessageAndNumberOfMessagesOne() {
        let sut = DefaultChatViewModel(repository: MockRepository(option: .onePassage), ballonViewModelInjector: ballonViewModelInjector)
        let newMessageExpectation = expectation(description: "new message arrived")
        
        checkPublisherSequence(publisher: sut.output.messageWasAdded, callCount: 1, storeIn: &cancellablesStore) {
            newMessageExpectation.fulfill()
        }
        
        XCTAssertEqual(sut.output.numberOfMessages, 1)
        wait(for: [newMessageExpectation], timeout: 1)
        
    }
    
    func test_initializeWithMultiplePassages_callsShowNewMessageAndNumberOfMessagesOneAndCallsChoiceWasMade() {
        let sut = DefaultChatViewModel(repository: MockRepository(option: .multiplePassages), ballonViewModelInjector: ballonViewModelInjector)
        
        let newMessageExpectation = expectation(description: "new message arrived")
        let choicesExpectation = expectation(description: "choices arrived")
        
        let wantedChoices: [[String]] = [["choice1", "choice2"]]

        checkPublisherSequence(publisher: sut.output.messageWasAdded, callCount: 1, storeIn: &cancellablesStore) {
            newMessageExpectation.fulfill()
        }
        
        checkPublisherSequence(publisher: sut.output.choices, toBeEqualTo: wantedChoices, storeIn: &cancellablesStore) {
            choicesExpectation.fulfill()
        }

        XCTAssertEqual(sut.output.numberOfMessages, 1)
    
        wait(for: [newMessageExpectation, choicesExpectation], timeout: 1)
    }

    func test_callOptionWasChosed_callsShowNewMessageAndNumberOfMessagesIncreases() {
        let sut = DefaultChatViewModel(repository: MockRepository(option: .multiplePassages), ballonViewModelInjector: ballonViewModelInjector)
        let newMessageExpectation = expectation(description: "new message arrived")

        checkPublisherSequence(publisher: sut.output.messageWasAdded, callCount: 2, storeIn: &cancellablesStore) {
            newMessageExpectation.fulfill()
        }

        sut.output.choices.sink { choices in
            if choices.count > 0 {
                sut.input.choiceWasMade.send(choices[0])
            }
        }.store(in: &cancellablesStore)

        wait(for: [newMessageExpectation], timeout: 1)
    }
    
    func test_callBallonViewModelAt_returnsTheRightViewModel() {
        let sut = DefaultChatViewModel(repository: MockRepository(option: .onePassage), ballonViewModelInjector: ballonViewModelInjector)
        
        sut.output.messageWasAdded.sink { message in
            XCTAssertEqual(sut.output.ballonViewModelAt(0).text, "rootText")
        }.store(in: &cancellablesStore)
    }
    
    func test_callBallonViewModelAt_returnsThetViewModelWithRightType() {
        let sut = DefaultChatViewModel(repository: MockRepository(option: .onePassage), ballonViewModelInjector: ballonViewModelInjector)
        
        sut.output.messageWasAdded.sink { message in
            XCTAssertTrue(sut.output.ballonViewModelAt(0) is MockBallonViewModel)
        }.store(in: &cancellablesStore)
    }
    
    func test_callBallonViewModelAtForTwoPassages_returnsTheRightViewModel() {
        let sut = DefaultChatViewModel(repository: MockRepository(option: .multiplePassages), ballonViewModelInjector: ballonViewModelInjector)
        let viewModelsExpectation = expectation(description: "ballon viewmodels are right")
        let wantedBallons: [MockBallonViewModel] = [MockBallonViewModel(text: "rootText"), MockBallonViewModel(text: "TextOfChoice1")]
        checkPublisherSequence(publisher: sut.ballonViewModelsPublisher, toBeEqualTo: wantedBallons, storeIn: &cancellablesStore) {
            viewModelsExpectation.fulfill()
        }
        
        sut.output.choices.sink { (choices) in
            if let firstChoice = choices.first {
                sut.input.choiceWasMade.send(firstChoice)
            }
        }.store(in: &cancellablesStore)
        
        wait(for: [viewModelsExpectation], timeout: 1)
        
    }
}

extension ChatViewModel {
    var ballonViewModelsPublisher: Publishers.CompactMap<CurrentValueSubject<Void, Never>, MockBallonViewModel> {
        self.output.messageWasAdded.compactMap { _ -> MockBallonViewModel? in
            self.output.ballonViewModelAt(self.output.numberOfMessages - 1) as? MockBallonViewModel
        }
    }
}
