//
//  AnySubjectTests.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 30/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
import Combine
@testable import StoryTreeiOS

class AnySubjectTests: XCTestCase {
    var cancellableStore: [AnyCancellable] = []

    override func tearDown() {
        cancellableStore = []
    }

    func test_callSendOutput_callsSendOutputAtAnySubject() {
        let currenctValueSubject = CurrentValueSubject<String, Never>("value")
        let passthroughSubject = PassthroughSubject<String, Never>()
        
        let anySubjectFromCurrentValue = currenctValueSubject.eraseToAnySubject()
        let anySubjectFromPassthrough = passthroughSubject.eraseToAnySubject()
        
        let outputExpectation = expectation(description: "output was delegated to the erased object")
        outputExpectation.expectedFulfillmentCount = 2

        checkPublisherSequence(publisher: currenctValueSubject, toBeEqualTo: ["value", "value1"], storeIn: &cancellableStore) {
            outputExpectation.fulfill()
        }
        
        checkPublisherSequence(publisher: passthroughSubject, toBeEqualTo: ["value1"], storeIn: &cancellableStore) {
            outputExpectation.fulfill()
        }
        
        anySubjectFromCurrentValue.send("value1")
        anySubjectFromPassthrough.send("value1")
        
        wait(for: [outputExpectation], timeout: 1)
    }
    
    func test_callSendCompletion_callsSendOutputAtAnySubject() {
        let currenctValueSubject = CurrentValueSubject<String, Never>("value")
        let passthroughSubject = PassthroughSubject<String, Never>()

        let anySubjectFromCurrentValue = currenctValueSubject.eraseToAnySubject()
        let anySubjectFromPassthrough = passthroughSubject.eraseToAnySubject()
        
        let completionExpectation = expectation(description: "completion was delegated to the erased object")
        completionExpectation.expectedFulfillmentCount = 2

        checkPublisherCompletion(publisher: currenctValueSubject, storeIn: &cancellableStore) {
            completionExpectation.fulfill()
        }
        
        checkPublisherCompletion(publisher: passthroughSubject, storeIn: &cancellableStore) {
            completionExpectation.fulfill()
        }
        
        anySubjectFromPassthrough.send(completion: .finished)
        anySubjectFromCurrentValue.send(completion: .finished)
        
        wait(for: [completionExpectation], timeout: 1)
    }
    
    func test_callSendSubscription_callsSendSubscriptionAtAnySubject() {
        let currenctValueSubject = CurrentValueSubject<String, Never>("value")
        let passthroughSubject = PassthroughSubject<String, Never>()
        
        let currentValueSubscriber = MockSubscriber(combineIdentifier: CombineIdentifier())
        let passthroughSubscriber = MockSubscriber(combineIdentifier: CombineIdentifier())

        let anySubjectFromCurrentValue = currenctValueSubject.eraseToAnySubject()
        let anySubjectFromPassthrough = passthroughSubject.eraseToAnySubject()
        
        let subscriptionExpectation = expectation(description: "subscription was delegated to eraser object")
        subscriptionExpectation.expectedFulfillmentCount = 2
        
        checkPublisherSequence(publisher: currentValueSubscriber.subscriptionWasSent, toBeEqualTo: ["value", "value1"], storeIn: &cancellableStore) {
            subscriptionExpectation.fulfill()
        }
        
        checkPublisherSequence(publisher: passthroughSubscriber.subscriptionWasSent, toBeEqualTo: ["value1"], storeIn: &cancellableStore) {
            subscriptionExpectation.fulfill()
        }
        
        anySubjectFromPassthrough.receive(subscriber: passthroughSubscriber)
        anySubjectFromCurrentValue.receive(subscriber: currentValueSubscriber)
        anySubjectFromPassthrough.send("value1")
        anySubjectFromCurrentValue.send("value1")
        
        wait(for: [subscriptionExpectation], timeout: 1)
    }
}
