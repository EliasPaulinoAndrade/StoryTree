//
//  PassageWithImage.swift
//  StoryTree
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

class PassageWithImage: PassageDecorator {
    let imageURL: URL

    init(_ decorated: Passage, withImageURL imageURL: URL) {
        self.imageURL = imageURL
        super.init(decorated)
    }
}
