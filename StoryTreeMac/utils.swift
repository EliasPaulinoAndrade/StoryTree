//
//  utils.swift
//  StoryTreeMac
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import StoryTree

func formattedPassage(_ passage: Passage) -> String {
    if let passageWithSections = passage.asPassageWithExtraSections {
        return passageWithSections.allSections.reduce("") { (totalResult, currentValue) -> String in
            "\(totalResult)\n\(currentValue)"
        }
    }
    return passage.text
}

func askUserInput(forActions actions: [String]) -> String? {
    guard let userAction = readLine() else {
        return nil
    }
    
    return actions.filter { (action) -> Bool in
        return action.uppercased().contains(userAction.uppercased())
    }.first
}

func findValidUserInput(forActions actions: [String]) -> String {
    return askUserInput(forActions: actions) ?? findValidUserInput(forActions: actions)
}
