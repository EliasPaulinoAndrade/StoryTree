//
//  ifIsSafe.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

protocol DefaultConvertible {
    associatedtype DefaultType
    static var defaultValue: DefaultType { get }
}

func ifIsSafe<T>(_ unsafeVar: T?, _ completion: (T) -> Void) {
    if let safeVar = unsafeVar {
        completion(safeVar)
    }
}

func ifIsSafe<I, O>(_ usafeVar: I?, default defaultValue: O, _ completion: (I) -> O) -> O {
    if let safeVar = usafeVar {
        return completion(safeVar)
    }
    return defaultValue
}

func ifIsSafe<I, O: DefaultConvertible>(_ usafeVar: I?, _ completion: (I) -> O) -> O where O.DefaultType == O {
    return ifIsSafe(usafeVar, default: O.defaultValue, completion)
}

extension Array: DefaultConvertible {
    typealias DefaultType = Array
    
    static var defaultValue: Array<Element> {
        return []
    }
}
