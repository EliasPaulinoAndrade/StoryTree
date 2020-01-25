//
//  Choice.swift
//  StoryTree
//
//  Created by Elias Paulino on 24/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

public struct Choice {
    public let title: String
    public let passage: Passage
    
    public init(_ title: String, _ passage: Passage) {
        self.title = title
        self.passage = passage
    }
    
    public init(_ title: String, _ passage: () -> Passage) {
        self.title = title
        self.passage = passage()
    }
}
