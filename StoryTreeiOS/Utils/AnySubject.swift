//
//  AnySubject.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 30/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Combine

class AnySubject<Output, Failure>: Subject where Failure: Error {
    typealias Output = Output
    typealias Failure = Failure

    private var sendOutput: (Output) -> Void
    private var sendCompletion: (Subscribers.Completion<Failure>) -> Void
    private var sendSubscription: (Subscription) -> Void
    private var publisher: AnyPublisher<Output, Failure>

    init<S: Subject>(subject: S) where S.Failure == Failure, S.Output == Output {
        self.sendOutput = subject.send
        self.sendCompletion = subject.send
        self.sendSubscription = subject.send
        self.publisher = subject.eraseToAnyPublisher()
    }

    func send(_ value: Output) {
        self.sendOutput(value)
    }

    func send(completion: Subscribers.Completion<Failure>) {
        self.sendCompletion(completion)
    }

    func send(subscription: Subscription) {
        self.sendSubscription(subscription)
    }

    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        publisher.receive(subscriber: subscriber)
    }
}

