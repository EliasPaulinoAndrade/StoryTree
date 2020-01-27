//
//  BallonViewModelInjector.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 26/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
@testable import StoryTreeiOS

func ballonViewModelInjector(_ text: String) -> PassageViewModel {
    return MockBallonViewModel(text: text)
}
