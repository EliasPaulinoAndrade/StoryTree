//
//  StoryRunner.swift
//  StoryTreeMac
//
//  Created by Elias Paulino on 24/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import StoryTree

class StoryRunner {
    var story: StoryTree
    weak var presenter: StoryPresenter?
    
    init(_ story: StoryTree) {
        self.story = story
    }
}

protocol StoryPresenter: AnyObject {
    
}
