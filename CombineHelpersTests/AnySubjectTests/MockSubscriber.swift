//
//  MockSubscriber.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 30/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine

struct MockSubscriber: Subscriber {
    typealias Input = String
    typealias Failure = Never
    
    var combineIdentifier: CombineIdentifier
    var subscriptionWasSent = PassthroughSubject<String, Never>()
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        subscriptionWasSent.send(input)
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<Never>) { }
}
