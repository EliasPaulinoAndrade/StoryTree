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
    let rootPassage: Passage
    var currentPassage: Passage! {
        didSet {
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
