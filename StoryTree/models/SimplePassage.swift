//
//  SimplePassage.swift
//  StoryTree
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

public class SimplePassage: InitializablePassage {
    public let text: String
    public var actions: [String: Passage]
    public var story: StoryTree?
    
    required public init(text: String, actions: [String: Passage]) {
        self.text = text
        self.actions = actions
    }
    
    public convenience init(_ text: String, actions: [String: Passage] = [:]) {
        self.init(text: text, actions: actions)
    }
}
