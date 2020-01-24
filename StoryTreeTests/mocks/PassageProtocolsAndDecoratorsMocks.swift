//
//  MockPassageProtocols.swift
//  StoryTreeTests
//
//  Created by Elias Paulino on 24/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
@testable import StoryTree

protocol MockPassageProtocol: Passage { }
protocol MockPassageProtocol2: Passage { }
class DecoratorMockImplementingProtocol: PassageDecorator, MockPassageProtocol { }
class DecoratorMockImplementingProtocol2: PassageDecorator, MockPassageProtocol2 { }
