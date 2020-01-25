//
//  StoryBuilderTests.swift
//  StoryTreeTests
//
//  Created by Elias Paulino on 24/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
@testable import StoryTree

class StoryBuilderTests: XCTestCase {
    func test_createStoryWithOneSubPassage_returnsTheCorrectTree() {
        let story: StoryTree = StoryTree(title: "title", description: "description",
            SimplePassage("description") {
                Choice("left", SimplePassage("leftDescription"))
                Choice("right", SimplePassage("rightDescription"))
            }
        )
        
        XCTAssertEqual(story.rootPassage.text, "description")
        XCTAssertNotNil(story.rootPassage.actions["left"])
        XCTAssertNotNil(story.rootPassage.actions["right"])
        XCTAssertEqual(story.rootPassage.actions["right"]!.text, "rightDescription")
        XCTAssertEqual(story.rootPassage.actions["left"]!.text, "leftDescription")
    }
    
    func test_createStoryWithTwoSubPassage_returnsTheCorrectTree() {
        let story = StoryTree(title: "title", description: "description",
            SimplePassage("description") {
                Choice("left") {
                    SimplePassage("leftText") {
                        Choice("north", SimplePassage("leftNorthText"))
                        Choice("left", SimplePassage("leftLeftText"))
                    }.withImage(URL(string: "imageTest")).withCondition({ _ in true })
                }
                Choice("north") {
                    PassageWithImage(
                        SimplePassage("northText") {
                            Choice("west", SimplePassage("nortWestText"))
                        }
                    ).withImage(URL(string: "imageTest"))
                }
            }
        )

        XCTAssertEqual(story.rootPassage.text, "description")
        XCTAssertNotNil(story.rootPassage.actions["left"])
        XCTAssertNotNil(story.rootPassage.actions["north"])
        XCTAssertNotNil(story.rootPassage.actions["left"]?.actions["left"])
        XCTAssertNotNil(story.rootPassage.actions["left"]?.actions["north"])
        XCTAssertNotNil(story.rootPassage.actions["north"]?.actions["west"])
        XCTAssertNotNil(story.rootPassage.actions["left"]?.asConditional)
        XCTAssertNotNil(story.rootPassage.actions["left"]?.asPassageWithImage)
        XCTAssertNotNil(story.rootPassage.actions["north"]?.asPassageWithImage)
    }
}
