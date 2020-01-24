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
        findPassage(forAction: action) { (passage) in
            if self.passageCondition?(passage) == true {
                super.goAhead(action: action)
            }
        }
    }
}
