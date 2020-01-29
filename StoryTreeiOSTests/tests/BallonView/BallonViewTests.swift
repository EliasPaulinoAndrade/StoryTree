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
        XCTAssertEqual(ballonView.ballonBackgroundView.superview, ballonView)
        XCTAssertEqual(ballonView.descriptionLabel.superview, ballonView.ballonBackgroundView)
        ballonView.viewModel = MockBallonViewModel(text: "testText")
        XCTAssertEqual(ballonView.descriptionLabel.text, "testText")
    }
    
    func test_setNilViewModel_viewKeepsCurrentState() {
        let ballonView = BallonView()
        
        XCTAssertEqual(ballonView.descriptionLabel.text, nil)
        ballonView.viewModel = nil
        XCTAssertEqual(ballonView.descriptionLabel.text, nil)
    }
    
    func test_initilizeWithCoder_setupsTheView() {
        let ballonView = UINib(nibName: "BallonViewMockZib", bundle: Bundle(for: MessagesViewTests.self)).instantiate(withOwner: nil, options: nil)[0] as? BallonView
        
        ballonView?.viewModel = MockBallonViewModel(text: "test")
        
        XCTAssertNotNil(ballonView)
        XCTAssertEqual(ballonView?.descriptionLabel.text, "test")
    }
}
