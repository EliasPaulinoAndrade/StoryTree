//
//  ConditionalPassageDecorator.swift
//  StoryTree
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

class ConditionalPassageDecorator: PassageDecorator, ConditionalPassage {
    var passageCondition: ((Passage) -> Bool)?
    
    override func goAhead(action: String) {
        guard let passage = actions[action] else {
            return
        }
        
        if self.passageCondition?(passage) == true {
            super.goAhead(action: action)
        }
    }
}
