//
//  BallonViewTests.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
@testable import StoryTreeiOS

class BallonViewTests: XCTestCase {
    func test_setViewModel_changesViewState() {
        let ballonView = BallonView()
        
        XCTAssertEqual(ballonView.textLabel.text, nil)
        ballonView.viewModel = MockViewModel(text: "testText")
        XCTAssertEqual(ballonView.textLabel.text, "testText")
    }
}

class MockViewModel: PassageViewModel {
    let text: String
    init(text: String) {
        self.text = text
    }
}
