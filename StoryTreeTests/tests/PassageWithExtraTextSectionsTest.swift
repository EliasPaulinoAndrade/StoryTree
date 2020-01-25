//
//  PassageWithExtraTextSectionsTest.swift
//  StoryTreeTests
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
@testable import StoryTree

class PassageWithExtraTextSectionsTest: XCTestCase {
    func test_addSection_sectionsIncludeMainText() {
        let sut = PassageWithExtraTextSections(SimplePassage("base text"), withExtraSections: ["section2", "section3"])

        XCTAssertEqual(sut.allSections, ["base text", "section2", "section3"])
        XCTAssertEqual(sut.extraSections, ["section2", "section3"])
    }
    
    func test_addSectionByCallingAddingTextSection_sectionsIncludeMainText() {
        let sut = PassageWithExtraTextSections(SimplePassage("base text")).addingTextSection("section2").addingTextSection("section3")
        
        XCTAssertEqual(sut.allSections, ["base text", "section2", "section3"])
        XCTAssertEqual(sut.extraSections, ["section2", "section3"])
    }
    
    func test_addSectionByCallingPassageMethodTwoTimes_onlyAddOneDecorator() {
        let simplePassage = SimplePassage("base text")
        let sut: PassageWithExtraTextSections = simplePassage.addingTextSection("section2").addingTextSection("section3")
        
        XCTAssertTrue(sut.decoratedPassage === simplePassage)
        XCTAssertEqual(sut.allSections, ["base text", "section2", "section3"])
    }
}
