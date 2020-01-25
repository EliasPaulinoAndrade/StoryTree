//
//  InitializablePassage.swift
//  StoryTree
//
//  Created by Elias Paulino on 24/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

public protocol InitializablePassage: Passage {
    init(text: String, actions: [String: Passage])
}
