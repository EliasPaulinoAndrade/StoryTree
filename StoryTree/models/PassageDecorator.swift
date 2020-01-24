//
//  PassageDecorator.swift
//  StoryTree
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

class PassageDecorator: Passage {
    var description: String {
        get {
            return decoratedPassage.description
        }
    }
    
    var actions: [String : Passage] {
        get {
            return decoratedPassage.actions
        } set {
            decoratedPassage.actions = newValue
        }
    }
    
    var story: StoryTree? {
        get {
            return decoratedPassage.story
        } set {
            decoratedPassage.story = newValue
        }
    }
    
    var decoratedPassage: Passage
    
    init(_ passage: Passage) {
        self.decoratedPassage = passage
    }
    
    func goAhead(action: String) {
        decoratedPassage.goAhead(action: action)
    }
    
    func add(action: String, toPassage passage: Passage) {
        decoratedPassage.add(action: action, toPassage: passage)
    }
}
