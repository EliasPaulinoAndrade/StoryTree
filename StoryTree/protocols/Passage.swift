//
//  Passage.swift
//  StoryTree
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

public protocol Passage: AnyObject {
    var text: String { get }
    var actions: [String: Passage] { get set }
    var story: StoryTree? { get set }
    
    func add(action: String, toPassage passage: Passage)
    func goAhead(action: String)
}

public extension Passage {
    var asConditional: ConditionalPassage? {
        return findPassageDecorator(ofType: ConditionalPassage.self)
    }
    
    func add(action: String, toPassage passage: Passage) {
        passage.story = self.story
        actions[action] = passage
    }
    
    func findPassage(forAction action: String, didFindCompletion: (Passage) -> Void ) {
        guard let passage = actions[action] else {
            return
        }
        
        didFindCompletion(passage)
    }
    
    func goAhead(action: String) {
        findPassage(forAction: action) { passage in
            story?.currentPassage = passage
        }
    }
    
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
