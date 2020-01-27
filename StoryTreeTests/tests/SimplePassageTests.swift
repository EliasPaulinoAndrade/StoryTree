//
//  SimplePassageTests.swift
//  StoryTreeTests
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import XCTest
@testable import StoryTree

class SimplePassageTests: XCTestCase {
    func test_initilizeSimplePassageWithTwoActionsWithNoStory_setsAllSubPassagesStoriesToNil() {
        let sut = SimplePassage(text: "test", actions: ["left": SimplePassage(""), "right": SimplePassage("")])
        
        sut.actions.values.forEach { (passage) in
            XCTAssertNil(passage.story)
        }
    }
    
    func test_initilizeSimplePassageWithTwoActionsAndAddStory_setsAllSubPassagesStories() {
        let sut = SimplePassage(text: "test", actions: ["left": SimplePassage(""), "right": SimplePassage("")])
        let story = StoryTree(title: "", description: "", sut)
        sut.story = story
        
        sut.actions.values.forEach { (passage) in
            XCTAssertNotNil(passage.story)
        }
    }
    
    func test_initilizeSimplePassageWithTwoActionsAndAddStoryWithNoStrongReference_theStoryReferenceIsLosen() {
        let sut = SimplePassage()
        sut.story = StoryTree(title: "", description: "", sut)
   
        XCTAssertNil(sut.story)
    }
    
    func test_compareSuceedByDoubleEqual_isEquivalentToTribleEqual() {
        let sut = SimplePassage()
        let sut2 = sut
        
        XCTAssertEqual(sut, sut2)
    }
    
    func test_compareFailByDoubleEqual_isEquivalentToTribleEqual() {
        let sut = SimplePassage()
        let sut2 = SimplePassage()
        
        XCTAssertNotEqual(sut, sut2)
    }
}
