//
//  StoryTreeRepository.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import StoryTree
import Combine
    
protocol StoryTreeRepository {
    var storyTree: AnyPublisher<StoryTree, Never> { get }    
}

