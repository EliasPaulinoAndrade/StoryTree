//
//  StoryTreeRepository.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import StoryTree
    
protocol StoryTreeRepository {
    func getTree(completion: (Result<StoryTree, Error>) -> Void)
}
