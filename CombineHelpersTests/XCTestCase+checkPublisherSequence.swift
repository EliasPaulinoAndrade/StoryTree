//
//  XCTestCase+.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 26/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
import Combine

@available(OSX 10.15, *)
public extension XCTestCase {
    func checkPublisherSequence<T: Equatable, PublisherType: Publisher>(
        publisher: PublisherType,
        toBeEqualTo sequence: [T],
        storeIn cancellablesStore: inout [AnyCancellable],
        _ completion: @escaping () -> Void) where PublisherType.Output == T {

        var valuesHistory: [T] = []
        
        publisher.sink(receiveCompletion: { _ in }, receiveValue: { (newValue) in
            valuesHistory.append(newValue)
            if valuesHistory.count == sequence.count, valuesHistory == sequence {
                completion()
            }
        }).store(in: &cancellablesStore)
    }
    
    func checkPublisherCompletion<PublisherType: Publisher>(publisher: PublisherType,
                                                            storeIn cancellablesStore: inout [AnyCancellable],
                                                            _ completion: @escaping () -> Void) {
        publisher.sink(receiveCompletion: { publisherCompletion in
            completion()
        }, receiveValue: { _ in }).store(in: &cancellablesStore)
    }
    
    func checkPublisherSequence<PublisherType: Publisher>(
        publisher: PublisherType,
        callCount: Int,
        storeIn cancellablesStore: inout [AnyCancellable],
        _ completion: @escaping () -> Void) where PublisherType.Failure == Never  {

        var valuesHistory: [PublisherType.Output] = []
        publisher.sink { newValue in
            valuesHistory.append(newValue)
            if valuesHistory.count == callCount {
                completion()
            }
        }.store(in: &cancellablesStore)
    }
}
