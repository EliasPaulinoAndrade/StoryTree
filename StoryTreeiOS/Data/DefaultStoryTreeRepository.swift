//
//  DefaultStoryTreeRepository.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 26/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import StoryTree

struct DefaultStoryTreeRepository: StoryTreeRepository {
    func getTree(completion: (Result<StoryTree, Error>) -> Void) {
        let story = StoryTree(title: "", description: "", SimplePassage("rootPassage"))
        completion(.success(story))
    }
}
