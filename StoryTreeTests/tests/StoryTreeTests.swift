//
//  StoryTreeTests.swift
//  StoryTreeTests
//
//  Created by Elias Paulino on 22/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
@testable import StoryTree

class StoryTreeTests: XCTestCase {
    func test_createStory_hasNoActionsInRootPassage() {
        let sut = makeSUT()
        XCTAssert(sut.rootPassage.actions.isEmpty)
    }
    
    func test_addActionToPassage_addsPassageNodeToActions() {
        let sut = makeSUT()
        let southPassage = makeSouthPassage()
        
        sut.rootPassage.add(action: "south", toPassage: southPassage)
        
        XCTAssertEqual(sut.rootPassage.actions.keys.count, 1)
        XCTAssertEqual(sut.rootPassage.actions.keys.first!, "south")
        XCTAssertTrue(sut.rootPassage.actions.values.first! === southPassage)
    }
    
    func test_storyWithNoActionsAndCallGoAhead_dontCallsCallback() {
        let sut = makeSUT()
        let sutSpy = StoryTreeSpy(tree: sut)
        
        sut.goAhead(action: "south")
        XCTAssertTrue(sutSpy.historyIsEqual(to: [sut.rootPassage]))
    }
    
    func test_storyWithOneActionAndCallGoAhead_callsCallback() {
        let sut = makeSUT()
        let southPassage = makeSouthPassage()
        let sutSpy = StoryTreeSpy(tree: sut)

        sut.rootPassage.add(action: "south", toPassage: southPassage)
        sut.goAhead(action: "south")
        
        XCTAssertTrue(sutSpy.historyIsEqual(to: [sut.rootPassage, southPassage]))
    }
    
    func test_storyWithTwoActionsAndCallGoAhead_callsRightCallback() {
        let sut = makeSUT()
        let northPassage = makeNorthPassage()
        let sutSpy = StoryTreeSpy(tree: sut)

        sut.rootPassage.add(action: "south", toPassage: makeSouthPassage())
        sut.rootPassage.add(action: "north", toPassage: northPassage)
        sut.goAhead(action: "north")

        XCTAssertTrue(sutSpy.historyIsEqual(to: [sut.rootPassage, northPassage]))
    }
    
    func test_goAheadTwoTimes_callsCallbackTwoTimes() {
        let sut = makeSUT()
        let southPassage = makeSouthPassage()
        let northPassage = makeNorthPassage()
        let sutSpy = StoryTreeSpy(tree: sut)
        
        sut.rootPassage.add(action: "south", toPassage: southPassage)
        southPassage.add(action: "north", toPassage: northPassage)
        
        sut.goAhead(action: "south")
        sut.goAhead(action: "north")
        
        XCTAssertTrue(sutSpy.historyIsEqual(to: [sut.rootPassage, southPassage, northPassage]))
    }
    
    func test_goAheadThreeTimesWithTwoActions_callsCallbackTwoTimes() {
        let sut = makeSUT()
        let southPassage = makeSouthPassage()
        let northPassage = makeNorthPassage()
        let sutSpy = StoryTreeSpy(tree: sut)
        
        sut.rootPassage.add(action: "south", toPassage: southPassage)
        southPassage.add(action: "north", toPassage: northPassage)
        
        sut.goAhead(action: "south")
        sut.goAhead(action: "north")
        sut.goAhead(action: "north")
        
        XCTAssertTrue(sutSpy.historyIsEqual(to: [sut.rootPassage, southPassage, northPassage]))
    }
    
    func test_storyWithOneActionAndCallGoAheadToWrongAction_dontCallsCallback() {
        let sut = makeSUT()
        let southPassage = makeSouthPassage()
        let sutSpy = StoryTreeSpy(tree: sut)
        
        sut.rootPassage.add(action: "south", toPassage: southPassage)
        sut.goAhead(action: "north")
        
        XCTAssertTrue(sutSpy.historyIsEqual(to: [sut.rootPassage]))
    }
    
    func test_storyWithOneActionAndFailedInActionConditionAndDecoratedPassage_dontCallsCalback() {
        let sut = makeSUT(
            rootPassage: ConditionalPassageDecorator(
                SimplePassage(text: "south", actions: [:])
            )
        )
        let sutSpy = StoryTreeSpy(tree: sut)
                
        sut.rootPassage.add(action: "south", toPassage: makeSouthPassage())
        sut.rootPassage.asConditional?.passageCondition = { passage in
            return false
        }
        
        sut.goAhead(action: "south")
        
        XCTAssertTrue(sutSpy.historyIsEqual(to: [sut.rootPassage]))
    }
    
    func test_storyWithOneActionAndSuceedInActionConditionAndDecoratedPassage_callsCalback() {
        let sut = makeSUT(
            rootPassage: ConditionalPassageDecorator(
                SimplePassage(text: "south", actions: [:])
            )
        )
        let southPassage = makeSouthPassage()
        let sutSpy = StoryTreeSpy(tree: sut)
                
        sut.rootPassage.add(action: "south", toPassage: southPassage)
        sut.rootPassage.asConditional?.passageCondition = { passage in
            return true
        }
        
        sut.goAhead(action: "south")
        
        XCTAssertTrue(sutSpy.historyIsEqual(to: [sut.rootPassage, southPassage]))
    }
    
    func test_goAheadTwoTimes_callsCallbackTwoTimesWhileUsingForeachActionMethod () {
        let sut = makeSUT()
        let southPassage = makeSouthPassage()
        let northPassage = makeNorthPassage()
        var passagesHistory: [Passage] = []
        
        sut.rootPassage.add(action: "south", toPassage: southPassage)
        southPassage.add(action: "north", toPassage: northPassage)
        
        sut.foreachAction { passage in
            passagesHistory.append(passage)
        }
        
        sut.goAhead(action: "south")
        sut.goAhead(action: "north")
        
        XCTAssertTrue(passagesHistory.isEqual(to: [sut.rootPassage, southPassage, northPassage]))
    }
    
    // MARK: - Helpers
    func makeSUT(rootPassage: Passage = SimplePassage(text: "something happend", actions: [:])) -> StoryTree {
        return StoryTree(title: "tree", description: "description", rootPassage)
    }
    
    func makeSouthPassage() -> Passage {
        return SimplePassage(text: "you are at south", actions: [:])
    }
    
    func makeNorthPassage() -> Passage {
        return SimplePassage(text: "you are at north", actions: [:])
    }
}
