//
//  DefaultInputViewModel.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 29/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
import Combine
@testable import StoryTreeiOS

class DefaultInputViewModelTests: XCTestCase {
    var cancellablesStore: [AnyCancellable] = []
    func test_inputChoices_transformInToChoicesViewModels() {
        let sutInput = CurrentValueSubject<[String], Never>(["choice1"])
        let sut = makeSUT(input: sutInput.eraseToAnyPublisher())
        let choicesExpectation = expectation(description: "correct viewmodels were sent")
        
        let wantedViewModels: [[MockChoiceViewModel]] = [
            [MockChoiceViewModel(choice: "choice1")],
            [MockChoiceViewModel(choice: "choice1"), MockChoiceViewModel(choice: "choice2")]
        ]

        checkPublisherSequence(
            publisher: sut.output.choices.castOutput(to: [MockChoiceViewModel].self),
            toBeEqualTo: wantedViewModels, storeIn: &cancellablesStore) {
            choicesExpectation.fulfill()
        }

        sutInput.send(["choice1", "choice2"])
        wait(for: [choicesExpectation], timeout: 1)
    }
    
    func test_inputNewMessage_transformInToNilMessageAndNewInput() {
        let sut = makeSUT()
        let messageNilExpectation = expectation(description: "message was set to nil")
        let wantedMessage: [String?] = [nil]
        checkPublisherSequence(publisher: sut.output.message, toBeEqualTo: wantedMessage, storeIn: &cancellablesStore) {
            messageNilExpectation.fulfill()
        }
        
        sut.input.messageWasSent.send("newMessage")
        wait(for: [messageNilExpectation], timeout: 1)
    }
    
    func test_inputNewMessageAfterMakeChoice_transformInToNilMessageAndNewInput() {
        let sut = makeSUT()
        let messageNilExpectation = expectation(description: "message was set to nil")
        let wantedMessage: [String?] = [nil, "choice1", nil]
        checkPublisherSequence(publisher: sut.output.message, toBeEqualTo: wantedMessage, storeIn: &cancellablesStore) {
            messageNilExpectation.fulfill()
        }
        
        sut.input.choiceWasMade.send("choice1")
        sut.input.messageWasSent.send("newMessage")
        wait(for: [messageNilExpectation], timeout: 1)
    }

    func makeSUT(input: AnyPublisher<[String], Never> = Just(["choice1"]).eraseToAnyPublisher()) -> DefaultInputViewModel {
        return DefaultInputViewModel(
            input: DefaultInputViewModel.Input(choices: input),
            choiceViewModelInjector: choiceViewModelInjector
        )
    }
}
