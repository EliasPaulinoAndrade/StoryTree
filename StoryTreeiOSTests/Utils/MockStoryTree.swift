//
//  MockStoryTree.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 26/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import StoryTree
import Combine
@testable import StoryTreeiOS

class MockStoryTree: StoryTree {
    enum Option {
        case onePassage, multiplePassages
    }

    convenience init(option: Option) {
        switch option {
        case .onePassage:
            self.init(title: "", description: "", SimplePassage("rootText"))
        case .multiplePassages:
            let rootPassage = SimplePassage("rootText") {
                Choice("choice1") {
                    SimplePassage("TextOfChoice1")
                }
                Choice("choice2") {
                    SimplePassage("textOfChoice2")
                }
            }
            self.init(title: "", description: "", rootPassage)
        }
    }
}
