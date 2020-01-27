//
//  IfIsSaveTests.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
@testable import StoryTreeiOS

class IfIsSafeTests: XCTestCase {
    func test_safeValue_executesTheCompletion() {
        ifIsSafe("safeValue") { str in
            XCTAssertEqual(str, "safeValue")
        }
    }
    
    func test_unsafeValue_dontExecutesTheCompletion() {
        let unsafeVar: String? = nil
        var completionWasCalled = false
        
        ifIsSafe(unsafeVar) { str in
            completionWasCalled = true
        }
        
        XCTAssertTrue(!completionWasCalled)
    }
}
