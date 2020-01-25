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
        
        XCTAssertEqual(ballonView.descriptionLabel.text, nil)
        XCTAssertEqual(ballonView.descriptionLabel.superview, ballonView)
        ballonView.viewModel = MockViewModel(text: "testText")
        XCTAssertEqual(ballonView.descriptionLabel.text, "testText")
    }
    
    func test_setNilViewModel_viewKeepsCurrentState() {
        let ballonView = BallonView()
        
        XCTAssertEqual(ballonView.descriptionLabel.text, nil)
        ballonView.viewModel = nil
        XCTAssertEqual(ballonView.descriptionLabel.text, nil)
    }
    
    func test_initilizeWithCoder_setupsTheView() {
        let ballonView = UINib(nibName: "BallonViewMockZib", bundle: Bundle(for: ChatViewTests.self)).instantiate(withOwner: nil, options: nil)[0] as? BallonView
        
        ballonView?.viewModel = MockViewModel(text: "teste")
        
        XCTAssertNotNil(ballonView)
        XCTAssertEqual(ballonView?.descriptionLabel.text, "teste")
    }
}

class MockViewModel: PassageViewModel {
    let text: String
    init(text: String) {
        self.text = text
    }
}
