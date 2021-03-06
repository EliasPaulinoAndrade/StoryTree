//
//  Passage.swift
//  StoryTree
//
//  Created by Elias Paulino on 23/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine

public protocol Passage: AnyObject {
    var text: String { get }
    var actions: [String: Passage] { get set }
    var story: StoryTree? { get set }
    
    func add(action: String, toPassage passage: Passage)
    func goAhead(action: String)
}

public extension Passage {
    func add(action: String, toPassage passage: Passage) {
        passage.story = self.story
        actions[action] = passage
    }
    
    func findPassage(forAction action: String, didFindCompletion: (Passage) -> Void ) {
        guard let passage = actions[action] else {
            return
        }
        
        didFindCompletion(passage)
    }
    
    func goAhead(action: String) {
        findPassage(forAction: action) { passage in
            story?.currentPassage = passage
        }
    }
}

@available(OSX 10.15, *)
public extension Passage {
    func goAhead<P: Publisher>(_ choiceMade: P, cancellable: inout [AnyCancellable]) where P.Output == String, P.Failure == Never {
        choiceMade.sink { (choice) in
            self.goAhead(action: choice)
        }.store(in: &cancellable)
    }
}
