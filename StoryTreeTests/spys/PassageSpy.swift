//
//  PassageSpy.swift
//  StoryTreeTests
//
//  Created by Elias Paulino on 24/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
@testable import StoryTree

class PassageSpy: Passage {
    var text: String
    var actions: [String : Passage]
    var story: StoryTree?
    
    var goAheadWasCalled = false
    
    init(description: String = "") {
        self.text = description
        self.actions = [:]
        self.story = nil
    }
    
    func goAhead(action: String) {
        goAheadWasCalled = true
    }
}
