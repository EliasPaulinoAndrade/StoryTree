//
//  PassageWithImageTests.swift
//  StoryTreeTests
//
//  Created by Elias Paulino on 24/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
@testable import StoryTree

class PassageWithImageTests: XCTestCase {
    func test_initilizeWithURL_savesTheURL() {
        let sut = PassageWithImage(SimplePassage("testText"), withImageURL: URL(string: "testURL"))
        
        XCTAssertNotNil(sut.imageURL)
    }
    
    func test_callWithImage_savesTheURL() {
        let sut = PassageWithImage(SimplePassage("testText")).withImage(URL(string: "testURL"))
        XCTAssertNotNil(sut.imageURL)
    }
}
