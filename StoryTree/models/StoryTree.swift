//
//  StoryTree.swift
//  StoryTree
//
//  Created by Elias Paulino on 22/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

public class StoryTree {
    public let title: String
    public let description: String
    public let rootPassage: Passage
    var currentPassage: Passage! {
        didSet {
            self.actionDidHappen?(currentPassage)
        }
    }
    
    public var actionDidHappen: ((Passage) -> Void)?
    
    public init(title: String, description: String, rootPassage: Passage) {
        self.title = title
        self.description = description
        self.rootPassage = rootPassage
        self.currentPassage = rootPassage
        
        rootPassage.story = self
    }
    
    public func goAhead(action: String) {
        self.currentPassage?.goAhead(action: action)
    }
}
