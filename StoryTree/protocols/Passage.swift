//
//  Passage.swift
//  StoryTree
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

protocol Passage: AnyObject {
    var description: String { get }
    var actions: [String: Passage] { get set }
    var story: StoryTree? { get set }
    
    func add(action: String, toPassage passage: Passage)
    func goAhead(action: String)
}

extension Passage {
    var asConditional: ConditionalPassage? {
        let condionalPassage = Self.findPassage(ofType: ConditionalPassage.self)
        return self as? ConditionalPassage ?? condionalPassage
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
    
    private static func findPassage<PassageType>(ofType passageType: PassageType.Type) -> ConditionalPassage? {
        
        
        return nil
    }
}
