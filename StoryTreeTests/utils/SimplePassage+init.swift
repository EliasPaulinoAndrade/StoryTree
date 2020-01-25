//
//  SimplePassage+init.swift
//  StoryTreeTests
//
//  Created by Elias Paulino on 24/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
@testable import StoryTree

extension SimplePassage {
    convenience init() {
        self.init(text: "", actions: [:])
    }
}
