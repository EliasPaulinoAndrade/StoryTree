//
//  PassageDecoratorTests.swift
//  StoryTreeTests
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
@testable import StoryTree

class PassageDecoratorTests: XCTestCase {
    func test_useDecorator_delegatesItToTheDecorated() {
        let passageSpy = PassageSpy(description: "testDescription")
        let sut = DecoratorMock(passageSpy)
        
        sut.setAtributtesForTest()
        
        XCTAssertEqual(sut.description, "testDescription")
        XCTAssertTrue(passageSpy.story === nil)
        XCTAssertEqual(passageSpy.actions.values.count, 1)
        XCTAssertEqual(passageSpy.goAheadWasCalled, true)
    }
    
    func test_useDecoratorWithTwoDecorators_delelegatesItForTheTwoDecorators() {
        let passageSpy = PassageSpy(description: "testDescription")
        let decoretedSut = DecoratorMock(passageSpy)
        let sut = DecoratorMock(decoretedSut)
        
        sut.setAtributtesForTest()
        
        XCTAssertEqual(sut.description, "testDescription")
        
        XCTAssertTrue(passageSpy.story === nil)
        XCTAssertEqual(passageSpy.actions.values.count, 1)
        XCTAssertEqual(passageSpy.goAheadWasCalled, true)
        
        XCTAssertTrue(decoretedSut.story === nil)
        XCTAssertEqual(decoretedSut.actions.values.count, 1)
        XCTAssertEqual(decoretedSut.goAheadWasCalled, true)
        XCTAssertEqual(decoretedSut.description, "testDescription")
    }
    
    func test_findDecoratorWithOneDecorator_returnsTheCorrectDecorator() {
        let passage = SimplePassage()
        let sut = DecoratorMockImplementingProtocol(passage)
            
        XCTAssertNotNil(sut.findPassageDecorator(ofType: MockPassageProtocol.self))
    }
    
    func test_findDecoratorWithTwoDecorator_returnsTheCorrectDecorators() {
        let passage = SimplePassage()
        let decoratedSut = DecoratorMockImplementingProtocol(passage)
        let sut = DecoratorMockImplementingProtocol2(decoratedSut)
            
        XCTAssertNotNil(sut.findPassageDecorator(ofType: MockPassageProtocol2.self))
        XCTAssertNotNil(sut.findPassageDecorator(ofType: MockPassageProtocol.self))
    }
    
    func test_findDecoratorWithNoDecorators_returnsNil() {
        let passage = SimplePassage()
        XCTAssertNil(passage.findPassageDecorator(ofType: MockPassageProtocol2.self))
        XCTAssertNil(passage.findPassageDecorator(ofType: MockPassageProtocol.self))
    }
}

extension Passage {
    func setAtributtesForTest() {
        story = nil
        actions = [:]
        add(action: "testAction", toPassage: PassageSpy())
        goAhead(action: "testAction")
    }
}

class PassageSpy: Passage {
    var description: String
    var actions: [String : Passage]
    var story: StoryTree?
    
    var goAheadWasCalled = false
    
    init(description: String = "") {
        self.description = description
        self.actions = [:]
        self.story = nil
    }
    
    func goAhead(action: String) {
        goAheadWasCalled = true
    }
}

class DecoratorMock: PassageDecorator {
    var goAheadWasCalled = false
    
    override func goAhead(action: String) {
        super.goAhead(action: action)
        goAheadWasCalled = true
    }
}

protocol MockPassageProtocol { }
protocol MockPassageProtocol2 { }
class DecoratorMockImplementingProtocol: PassageDecorator, MockPassageProtocol { }
class DecoratorMockImplementingProtocol2: PassageDecorator, MockPassageProtocol2 { }
