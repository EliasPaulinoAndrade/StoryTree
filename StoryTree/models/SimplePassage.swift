//
//  SimplePassage.swift
//  StoryTree
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

open class SimplePassage: InitializablePassage, Equatable {
    public let text: String
    public var actions: [String: Passage]
    weak public var story: StoryTree? {
        didSet {
            self.setSubPassages(story: self.story)
        }
    }
    
    required public init(text: String, actions: [String: Passage]) {
        self.text = text
        self.actions = actions
        
        self.setSubPassages(story: self.story)
    }
    
    public convenience init(_ text: String, actions: [String: Passage] = [:]) {
        self.init(text: text, actions: actions)
    }
    
    private func setSubPassages(story: StoryTree?) {
        self.actions.values.forEach { [weak self] (passage) in
            passage.story = self?.story
        }
    }
    
    public static func == (lhs: SimplePassage, rhs: SimplePassage) -> Bool {
        return lhs === rhs
    }
}
