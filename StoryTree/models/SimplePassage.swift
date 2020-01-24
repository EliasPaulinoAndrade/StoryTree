//
//  SimplePassage.swift
//  StoryTree
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

class SimplePassage: Passage {
    let description: String
    var actions: [String: Passage]
    var story: StoryTree?
    
    init(description: String, actions: [String: Passage]) {
        self.description = description
        self.actions = actions
    }
}
