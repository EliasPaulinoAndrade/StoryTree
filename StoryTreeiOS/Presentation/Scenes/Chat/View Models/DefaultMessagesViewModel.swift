//
//  DefaultChatViewModel.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine
import StoryTree

struct MessagesOutput: MessagesViewModel.MessagesOutput {
    var messages: AnyPublisher<[PassageViewModel], Never>
}

struct MessagesInput: MessagesViewModel.MessagesInput {
    var messages: AnyPublisher<[String], Never>
}

class DefaultMessagesViewModel: MessagesViewModel {
    typealias Input = MessagesInput
    typealias Output = MessagesOutput
    
    var input: MessagesViewModel.MessagesInput

    private var cancellables: [AnyCancellable] = []
    private let ballonViewModelInjector: Injector<PassageViewModel, String>
    private var passagesHistory: [Passage] = []
    
    init(input: Input, ballonViewModelInjector: @escaping Injector<PassageViewModel, String>) {
        self.input = input
        self.ballonViewModelInjector = ballonViewModelInjector
    }
    
    func transform(input: MessagesViewModel.MessagesInput) -> MessagesViewModel.MessagesOutput {
        return Output(messages: input.messages.map { (messages) -> [PassageViewModel] in
            return messages.map(self.ballonViewModelInjector)
        }.eraseToAnyPublisher())
    }
    
//    private func getStory() {
//        repository.getTree { (result) in
//            switch result {
//            case .success(let story):
//                formatInputAndOutput(forStory: story)
//            case .failure:
//                break
//            }
//        }
//    }
    
//    private func formatInputAndOutput(forStory story: StoryTree) {
//        story.foreachAction { [weak self] passage in
//            ifIsSafe(self) { (self) in
//                self.passagesHistory.append(passage)
//                self.output.messages.send(self.passagesHistory.map({ self.ballonViewModelInjector($0.text) }))
//                self.output.choices.send(Array(passage.actions.keys.sorted()))
//            }
//        }
//    }
}

extension Subject {
    func eraseToAnySubject() -> AnySubject<Output, Failure> {
        return AnySubject(subject: self)
    }
}

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

//struct AnyPublisher<Output, Failure> : CustomStringConvertible, CustomPlaygroundDisplayConvertible where Failure : Error

extension Publisher {
    func asCurrentValueSubject(initialValue: Output, store: inout [AnyCancellable]) -> CurrentValueSubject<Output, Failure> {
        let currentValueSubject = CurrentValueSubject<Output, Failure>(initialValue)

        self.sink(receiveCompletion: { (errorCompletion:  Subscribers.Completion<Failure>) in
            currentValueSubject.send(completion: errorCompletion)
        }, receiveValue:  { (output: Output) in
            currentValueSubject.send(output)
        }).store(in: &store)

        
        return currentValueSubject
    }
}
