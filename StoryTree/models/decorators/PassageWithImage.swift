//
//  PassageWithImage.swift
//  StoryTree
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

public class PassageWithImage: PassageDecorator {
    var imageURL: URL?

    public init(_ decorated: Passage, withImageURL imageURL: URL? = nil) {
        self.imageURL = imageURL
        super.init(decorated)
    }
    
    @discardableResult
    public func withImage(_ url: URL?) -> PassageWithImage {
        self.imageURL = url
        return self
    }
}

public extension Passage {
    var asPassageWithImage: PassageWithImage? {
        return findPassageDecorator(ofType: PassageWithImage.self)
    }
    
    func withImage(_ url: URL?) -> PassageWithImage {
        return PassageWithImage(self).withImage(url)
    }
}
