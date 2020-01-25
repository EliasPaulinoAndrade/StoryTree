//
//  PassageDecorator.swift
//  StoryTree
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

public class PassageDecorator: Passage {
    public var text: String {
        get {
            return decoratedPassage.text
        }
    }
    
    public var actions: [String : Passage] {
        get {
            return decoratedPassage.actions
        } set {
            decoratedPassage.actions = newValue
        }
    }
    
    public var story: StoryTree? {
        get {
            return decoratedPassage.story
        } set {
            decoratedPassage.story = newValue
        }
    }
    
    public var decoratedPassage: Passage
    
    init(_ passage: Passage) {
        self.decoratedPassage = passage
    }
    
    public func goAhead(action: String) {
        decoratedPassage.goAhead(action: action)
    }
    
    public func add(action: String, toPassage passage: Passage) {
        decoratedPassage.add(action: action, toPassage: passage)
    }
}

public extension Passage {
    func findPassageDecorator<PassageType>(ofType passageType: PassageType.Type) -> PassageType? {
        var currentDecorator: PassageDecorator? = self as? PassageDecorator
        while(currentDecorator != nil) {
            if let currentDecoratorAsType = currentDecorator as? PassageType {
                return currentDecoratorAsType
            }
          
            currentDecorator = currentDecorator?.decoratedPassage as? PassageDecorator
        }

        return nil
    }
}
