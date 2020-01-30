//
//  DefaultChatViewModelTests.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 30/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
import Combine
import StoryTree
@testable import StoryTreeiOS

class DefaultChatViewModelTests: XCTestCase {
    
    var cancellableStore: [AnyCancellable] = []
    
    override func tearDown() {
        cancellableStore = []
    }
    
    func test_initialize_withCorrectSubViewModels() {
        let chatInput = ChatInput(passages: PassthroughSubject<Passage, Never>().eraseToAnyPublisher())
        let sut = DefaultChatViewModel(input: chatInput,
                                       inputViewModelInjector: inputViewModelInjector,
                                       messagesViewModelInjector: messagesViewModelInjector)
                
        XCTAssertTrue(sut.subViewModels.inputViewModel is MockInputViewModel)
        XCTAssertTrue(sut.subViewModels.messagesViewModel is MockMessagesViewModel)
    }
    
    func test_inputPassageChanges_transformPassageIntoInputViewModelInput() {
        let inputSubject = CurrentValueSubject<Passage, Never>(SimplePassage(option: .multiplePassages))
        let chatInput = ChatInput(passages: inputSubject.eraseToAnyPublisher())
        let choicesExpectation = expectation(description: "choices were sent to the inputview")
        let sut = DefaultChatViewModel(input: chatInput,
                                       inputViewModelInjector: inputViewModelInjector,
                                       messagesViewModelInjector: messagesViewModelInjector)
        let inputViewViewModel = sut.subViewModels.inputViewModel as! MockInputViewModel
        
        checkPublisherSequence(publisher: inputViewViewModel.choiceWasMadeSubject,
                               toBeEqualTo: [["choice1", "choice2"], []],
                               storeIn: &cancellableStore) {
            choicesExpectation.fulfill()
        }
        
        inputSubject.send(SimplePassage("secondPassage"))
        
        wait(for: [choicesExpectation], timeout: 1)
    }
    
    func test_inputPassageChanges_transformsPassageIntoMessagesViewModelInput() {
        let inputSubject = CurrentValueSubject<Passage, Never>(SimplePassage(option: .multiplePassages))
        let chatInput = ChatInput(passages: inputSubject.eraseToAnyPublisher())
        let choicesExpectation = expectation(description: "choices were sent to the inputview")
        let sut = DefaultChatViewModel(input: chatInput,
                                       inputViewModelInjector: inputViewModelInjector,
                                       messagesViewModelInjector: messagesViewModelInjector)
        let messagesViewModel = sut.subViewModels.messagesViewModel as! MockMessagesViewModel
        
        checkPublisherSequence(publisher: messagesViewModel.messagesInputSubject,
                               toBeEqualTo: [["rootText"], ["rootText", "secondPassage"]],
                               storeIn: &cancellableStore) {
            choicesExpectation.fulfill()
        }
        
        inputSubject.send(SimplePassage("secondPassage"))
        
        wait(for: [choicesExpectation], timeout: 1)
    }
}
