//
//  DefaultStoryTreeRepository.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 26/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import StoryTree
import Combine

struct DefaultStoryTreeRepository: StoryTreeRepository {
    var storyTree: AnyPublisher<StoryTree, Never> {
        let story = StoryTree(title: "", description: "", SimplePassage("rootPassage wqe wqe wqe wqe weweqwewqewe qwewq"))
        return Just(story).eraseToAnyPublisher()
    }
}
