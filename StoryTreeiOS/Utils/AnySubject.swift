//
//  AnySubject.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 30/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Combine

@available(OSX 10.15, *)
public class AnySubject<Output, Failure>: Subject where Failure: Error {
    public typealias Output = Output
    public typealias Failure = Failure

    private var sendOutput: (Output) -> Void
    private var sendCompletion: (Subscribers.Completion<Failure>) -> Void
    private var sendSubscription: (Subscription) -> Void
    private var publisher: AnyPublisher<Output, Failure>

    public init<S: Subject>(subject: S) where S.Failure == Failure, S.Output == Output {
        self.sendOutput = subject.send
        self.sendCompletion = subject.send
        self.sendSubscription = subject.send
        self.publisher = subject.eraseToAnyPublisher()
    }

    public func send(_ value: Output) {
        self.sendOutput(value)
    }

    public func send(completion: Subscribers.Completion<Failure>) {
        self.sendCompletion(completion)
    }

    public func send(subscription: Subscription) {
        self.sendSubscription(subscription)
    }

    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        publisher.receive(subscriber: subscriber)
    }
}

