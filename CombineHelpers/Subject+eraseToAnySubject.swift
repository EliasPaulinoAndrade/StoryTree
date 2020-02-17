//
//  Subject+erase.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 30/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine

@available(OSX 10.15, *)
public extension Subject {
    func eraseToAnySubject() -> AnySubject<Output, Failure> {
        return AnySubject(subject: self)
    }
}
