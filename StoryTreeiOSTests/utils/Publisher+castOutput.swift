//
//  Publisher+castOutput.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 29/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine

@available(OSX 10.15, *)
extension Publisher where Failure == Never {
    func castOutput<O>(to newOutputType: O.Type) -> AnyPublisher<O, Never> {
        return self.compactMap { (output) -> O? in
            return output as? O
        }.eraseToAnyPublisher()
    }
}
