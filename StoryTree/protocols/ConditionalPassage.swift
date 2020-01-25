//
//  ConditionalPassage.swift
//  StoryTree
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

public protocol ConditionalPassage: Passage {
    var passageCondition: ((Passage) -> Bool)? { get set }
}
