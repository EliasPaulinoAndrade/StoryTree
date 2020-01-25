//
//  PassageBuilder.swift
//  StoryTree
//
//  Created by Elias Paulino on 24/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

@_functionBuilder
public struct PassageBuilder {
    public static func buildBlock(_ segments: Choice...) -> [String: Passage] {
        Dictionary(uniqueKeysWithValues: segments.map { action in
            (action.title, action.passage)
        })
    }
}

public extension SimplePassage {
    convenience init(_ text: String, @PassageBuilder _ content: () -> [String: Passage]) {
        self.init(text: text, actions: content())
    }
    
    convenience init(_ text: String, @PassageBuilder _ content: () -> Choice) {
        self.init(text: text, actions: [content().title: content().passage])
    }
}
