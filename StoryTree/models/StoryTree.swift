//
//  StoryTree.swift
//  StoryTree
//
//  Created by Elias Paulino on 22/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import Combine

public typealias ActionCompletion = ((Passage) -> Void)

open class StoryTree {
    public let title: String
    public let description: String
    public let rootPassage: Passage
    public var currentPassage: Passage! {
        didSet {
            self.actionDidHappen?(currentPassage)
            
            if #available(OSX 10.15, *) {
                self.foreachAction.send(currentPassage)
            }
        }
    }
    
    public var actionDidHappen: ActionCompletion? {
        didSet {
            if self.rootPassage === self.currentPassage {
                self.actionDidHappen?(self.rootPassage)
            }
        }
    }
    
    @available(OSX 10.15, *)
    lazy public var foreachAction: CurrentValueSubject<Passage, Never> = .init(currentPassage)
    
    public init(title: String, description: String, _ rootPassage: Passage) {
        self.title = title
        self.description = description
        self.rootPassage = rootPassage
        self.currentPassage = rootPassage
        
        rootPassage.story = self
    }
    
    public func goAhead(action: String) {
        self.currentPassage?.goAhead(action: action)
    }
    
    public func foreachAction(_ completion: @escaping ActionCompletion) {
        self.actionDidHappen = completion
    }
}
