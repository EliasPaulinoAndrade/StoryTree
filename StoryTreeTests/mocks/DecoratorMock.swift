//
//  DecoratorMock.swift
//  StoryTreeTests
//
//  Created by Elias Paulino on 24/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
@testable import StoryTree

class DecoratorMock: PassageDecorator {
    var goAheadWasCalled = false
    
    override func goAhead(action: String) {
        super.goAhead(action: action)
        goAheadWasCalled = true
    }
}
