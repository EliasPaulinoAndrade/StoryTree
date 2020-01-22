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
    
    func test_createStoryWithImagePassage_savesTheImage() {
        let rootPassage = PassageWithImage(
            description: "something happend",
            imageURL: URL(string: "fakeURL")!,
            actions: [:]
        )
        let _ = makeSUT(rootPassage: rootPassage)
        
        XCTAssertTrue(rootPassage.imageURL.absoluteString == "fakeURL")
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
        var actionHappen = false
        
        sut.actionDidHappen = { passage in
            actionHappen = true
        }
        
        sut.goAhead(action: "south")
        
        XCTAssertTrue(!actionHappen)
    }
    
    func test_storyWithOneActionAndCallGoAhead_callsCallback() {
        let sut = makeSUT()
        let southPassage = makeSouthPassage()
        var calledPassage: Passage?

        sut.rootPassage.add(action: "south", toPassage: southPassage)
        sut.actionDidHappen = { passage in
            calledPassage = passage
        }

        sut.goAhead(action: "south")

        XCTAssertNotNil(calledPassage)
        XCTAssertTrue(calledPassage === southPassage)
    }
    
    func test_storyWithTwoActionsAndCallGoAhead_callsRightCallback() {
        let sut = makeSUT()
        let northPassage = makeNorthPassage()
        var actionHappen = false

        sut.rootPassage.add(action: "south", toPassage: makeSouthPassage())
        sut.rootPassage.add(action: "north", toPassage: northPassage)

        sut.actionDidHappen = { passage in
            XCTAssertTrue(passage === northPassage)
            actionHappen = true
        }

        sut.goAhead(action: "north")

        XCTAssertTrue(actionHappen)
    }
    
    func test_goAheadTwoTimes_callsCallbackTwoTimes() {
        let sut = makeSUT()
        let southPassage = makeSouthPassage()
        let northPassage = makeNorthPassage()
        
        sut.rootPassage.add(action: "south", toPassage: southPassage)
        southPassage.add(action: "north", toPassage: northPassage)
        
        var traveledPassages: [Passage] = []
        
        sut.actionDidHappen = { passage in
            traveledPassages.append(passage)
            sut.goAhead(action: "north")
        }
    
        sut.goAhead(action: "south")
        
        XCTAssertTrue(traveledPassages.first === southPassage)
        XCTAssertTrue(traveledPassages[1] === northPassage)
    }
    
    func test_goAheadThreeTimesWithTwoActions_callsCallbackTwoTimes() {
        let sut = makeSUT()
        let southPassage = makeSouthPassage()
        let northPassage = makeNorthPassage()
        
        sut.rootPassage.add(action: "south", toPassage: southPassage)
        southPassage.add(action: "north", toPassage: northPassage)
        
        var passagesCount = 0
        sut.actionDidHappen = { _ in
            passagesCount += 1
        }
        
        sut.goAhead(action: "south")
        sut.goAhead(action: "north")
        sut.goAhead(action: "north")
        
        XCTAssertTrue(passagesCount == 2)
    }
    
    func test_storyWithOneActionAndCallGoAheadToWrongAction_dontCallsCallback() {
        let sut = makeSUT()
        let southPassage = makeSouthPassage()
        var actionHappen = false

        sut.rootPassage.add(action: "south", toPassage: southPassage)
        sut.actionDidHappen = { passage in
            XCTAssertTrue(passage === southPassage)
            actionHappen = true
        }

        sut.goAhead(action: "north")

        XCTAssertTrue(!actionHappen)
    }
    
    func test_storyWithOneActionAndFailedInActionCondition_dontCallsCalback() {
        let sut = makeSUT(rootPassage: SimpleConditionalPassage(description: "tree", actions: [:]))
        let southPassage = makeSouthPassage()
        var actionHappen = false
        
        sut.rootPassage.add(action: "south", toPassage: southPassage)
        sut.rootPassage.asConditional?.passageCondition = { passage in
            return false
        }
        
        sut.actionDidHappen = { passage in
            actionHappen = true
        }
        
        sut.goAhead(action: "south")
        
        XCTAssertTrue(!actionHappen)
    }
    
    func test_storyWithOneActionAndSuceedInActionCondition_callsCallback() {
        let sut = makeSUT(rootPassage: SimpleConditionalPassage(description: "tree", actions: [:]))
        let southPassage = makeSouthPassage()
        var actionHappen = false

        sut.rootPassage.add(action: "south", toPassage: southPassage)
        sut.rootPassage.asConditional?.passageCondition = { passage in
           return true
        }

        sut.actionDidHappen = { passage in
           actionHappen = true
        }

        sut.goAhead(action: "south")

        XCTAssertTrue(actionHappen)
    }
    
    
    
    // MARK: - Helpers

    func makeSUT(rootPassage: Passage = SimplePassage(description: "something happend", actions: [:])) -> StoryTree {
        return StoryTree(title: "tree", description: "description", rootPassage: rootPassage)
    }
    
    func makeSouthPassage() -> Passage {
        return SimplePassage(description: "you are at south", actions: [:])
    }
    
    func makeNorthPassage() -> Passage {
        return SimplePassage(description: "you are at north", actions: [:])
    }
}
