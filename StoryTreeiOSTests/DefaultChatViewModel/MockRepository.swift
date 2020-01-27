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
    
    func getTree(completion: (Result<StoryTree, Error>) -> Void) {
        completion(.success(MockStoryTree(option: option)))
    }
}
