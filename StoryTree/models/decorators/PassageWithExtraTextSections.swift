//
//  PassageWithExtraTextSections.swift
//  StoryTree
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

public class PassageWithExtraTextSections: PassageDecorator {
    lazy var sections: [String] = [self.text]
    
    public var extraSections: [String] {
        return Array(sections.dropFirst())
    }
    
    public var allSections: [String] {
        return sections
    }
    
    public init(_ passage: Passage, withExtraSections extraSections: [String] = []) {
        super.init(passage)
        self.sections.append(contentsOf: extraSections)
    }
    
    public func addingTextSection(_ text: String) -> PassageWithExtraTextSections {
        self.sections.append(text)
        return self
    }
}

extension Passage {
    public var asPassageWithExtraSections: PassageWithExtraTextSections? {
        return findPassageDecorator(ofType: PassageWithExtraTextSections.self)
    }
    
    public func addingTextSection(_ text: String) -> PassageWithExtraTextSections {
        let passageWithSections = self.asPassageWithExtraSections ?? PassageWithExtraTextSections(self)
        return passageWithSections.addingTextSection(text)
    }
}
