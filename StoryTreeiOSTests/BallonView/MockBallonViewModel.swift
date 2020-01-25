//
//  MockBallonViewModel.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
@testable import StoryTreeiOS

class MockBallonViewModel: PassageViewModel {
    let text: String
    init(text: String) {
        self.text = text
    }
}
