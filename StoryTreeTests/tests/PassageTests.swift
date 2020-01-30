//
//  PassageTests.swift
//  StoryTreeTests
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine
import XCTest
@testable import StoryTree

class PassageTests: XCTestCase {
    func test_passage_findPassageWithCorrectAction_callsCallback() {
        let sut = SimplePassage()
        let testPassage = SimplePassage()
        var callbackWasCalled = false
        
        sut.add(action: "testAction", toPassage: testPassage)
        sut.findPassage(forAction: "testAction") { (passage) in
            callbackWasCalled = true
        }
        
        XCTAssertEqual(callbackWasCalled, true)
    }
    
    func test_passage_findPassageWithWrongAction_dontCallsCallback() {
        let sut = SimplePassage()
        let testPassage = SimplePassage()
        var callbackWasCalled = false
        
        sut.add(action: "testAction", toPassage: testPassage)
        sut.findPassage(forAction: "wrongAction") { (passage) in
            callbackWasCalled = true
        }
        
        XCTAssertEqual(callbackWasCalled, false)
    }
    
    func test_goAheadSubject_bla() {
        guard #available(OSX 10.15, *) else { return }
        
        let subPassage = SimplePassage()
        let sut = SimplePassage("rootPassage") {
            Choice("choice1") {
                subPassage
            }
        }
        
        let tree = StoryTree(title: "", description: "", sut)
        var cancellableStore: [AnyCancellable] = []
        let newActionExpectation = expectation(description: "new action arrived")
        
        checkPublisherSequence(publisher: tree.foreachAction.castOutput(to: SimplePassage.self),
                               toBeEqualTo: [sut, subPassage],
                               storeIn: &cancellableStore) {
            newActionExpectation.fulfill()
        }
        
        sut.goAhead(Just("choice1"), cancellable: &cancellableStore)
        
        wait(for: [newActionExpectation], timeout: 1)
    }
}
