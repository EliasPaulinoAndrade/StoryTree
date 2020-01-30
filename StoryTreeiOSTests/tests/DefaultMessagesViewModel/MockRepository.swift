//
//  MockRepository.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 26/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import StoryTree
import Combine
@testable import StoryTreeiOS

struct MockRepository: StoryTreeRepository {
    
    var option: MockStoryTree.Option
    
    var storyTree: AnyPublisher<StoryTree, Never> {
        return Just(MockStoryTree(option: option)).eraseToAnyPublisher()
    }
}
