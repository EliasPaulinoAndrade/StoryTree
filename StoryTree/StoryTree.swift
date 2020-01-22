//
//  StoryTree.swift
//  StoryTree
//
//  Created by Elias Paulino on 22/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

class StoryTree {
    let title: String
    let description: String
    var rootPassage: Passage
    var currentPassage: Passage? {
        didSet {
            guard let currentPassage = self.currentPassage else {
                return
            }
            self.actionDidHappen?(currentPassage)
        }
    }
    
    var actionDidHappen: ((Passage) -> Void)?
    
    init(title: String, description: String, rootPassage: Passage) {
        self.title = title
        self.description = description
        self.rootPassage = rootPassage
        self.currentPassage = rootPassage
        
        rootPassage.story = self
    }
    
    func goAhead(action: String) {
        self.currentPassage?.goAhead(action: action)
    }
}

protocol Passage: AnyObject {
    var description: String { get }
    var actions: [String: Passage] { get set }
    var story: StoryTree? { get set }
    
    func add(action: String, toPassage passage: Passage)
    func goAhead(action: String)
}

extension Passage {
    var asConditional: ConditionalPassage? {
        return self as? ConditionalPassage
    }
    func add(action: String, toPassage passage: Passage) {
        passage.story = self.story
        actions[action] = passage
    }
    
    func goAhead(action: String) {
        guard let passage = actions[action] else {
            return
        }
        story?.currentPassage = passage
    }
}

protocol ConditionalPassage: Passage {
    var passageCondition: ((Passage) -> Bool)? { get set }
}

extension ConditionalPassage {
    func goAhead(action: String) {
        guard let passage = actions[action] else {
            return
        }
        
        if self.passageCondition?(passage) == true {
            story?.currentPassage = passage
        }
    }
}

class SimplePassage: Passage {
    let description: String
    var actions: [String: Passage]
    var story: StoryTree?
    
    init(description: String, actions: [String: Passage]) {
        self.description = description
        self.actions = actions
    }
}

class SimpleConditionalPassage: ConditionalPassage {
    let description: String
    var actions: [String: Passage]
    var story: StoryTree?
    var passageCondition: ((Passage) -> Bool)?
    
    init(description: String, actions: [String: Passage]) {
        self.description = description
        self.actions = actions
    }
}

class PassageWithImage: Passage {
    let description: String
    let imageURL: URL
    var actions: [String: Passage]
    var story: StoryTree?

    init(description: String, imageURL: URL, actions: [String: Passage]) {
        self.description = description
        self.imageURL = imageURL
        self.actions = actions
    }
}
