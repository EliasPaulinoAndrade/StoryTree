//
//  ifIsSafe.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

func ifIsSafe<T>(_ unsafeVar: T?, _ completion: (T) -> Void) {
    if let safeVar = unsafeVar {
        completion(safeVar)
    }
}
