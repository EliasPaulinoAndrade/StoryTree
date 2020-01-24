//
//  StoryTreeSpy.swift
//  StoryTreeTests
//
//  Created by Elias Paulino on 24/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
@testable import StoryTree

class StoryTreeSpy {
    var passagesHistory: [Passage] = []
    init(tree: StoryTree) {
        tree.actionDidHappen = { [weak self] passage in
            self?.passagesHistory.append(passage)
        }
    }
    
    func historyIsEqual(to passages: [Passage]) -> Bool {
        guard passages.count == passagesHistory.count else {
            return false
        }
        return zip(passagesHistory, passages).allSatisfy { (passages) -> Bool in
            passages.0 === passages.1
        }
    }
}
