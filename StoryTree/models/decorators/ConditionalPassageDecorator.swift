//
//  ConditionalPassageDecorator.swift
//  StoryTree
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

public typealias PassageCondition = ((Passage) -> Bool)

public class ConditionalPassageDecorator: PassageDecorator, ConditionalPassage {
    public var passageCondition: PassageCondition?
    
    override public func goAhead(action: String) {
        findPassage(forAction: action) { (passage) in
            if self.passageCondition?(passage) == true {
                super.goAhead(action: action)
            }
        }
    }
    
    public func withCondition(_ condition: @escaping PassageCondition) -> ConditionalPassageDecorator {
        self.passageCondition = condition
        
        return self
    }
}

extension Passage {
    public var asConditional: ConditionalPassage? {
        return findPassageDecorator(ofType: ConditionalPassage.self)
    }
    
    public func withCondition(_ condition: @escaping PassageCondition) -> ConditionalPassageDecorator {
        return ConditionalPassageDecorator(self).withCondition(condition)
    }
}
