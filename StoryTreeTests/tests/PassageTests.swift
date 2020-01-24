//
//  PassageTests.swift
//  StoryTreeTests
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

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
}
