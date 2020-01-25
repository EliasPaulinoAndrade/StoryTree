//
//  main.swift
//  StoryTreeMac
//
//  Created by Elias Paulino on 24/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation
import StoryTree

let story = StoryTree(title: "Title", description: "Description",
SimplePassage("You are in the spooky foyer! To the left is a creepy bathroom and straight ahead is a terrifying kitchen.") {
    Choice("Go left into the bathroom") {
        SimplePassage("The bathroom contains a scary looking toilet that keeps running no matter how many times you jiggle the handle. Think of all that wasted water! Al Gore's worse nightmare!")
    }
    Choice("Head straight to the kitchen") {
        SimplePassage("The kitchen is dirty but on the rickety looking table is a delicious chocolate cake, a knife, and a plate with a fork.") {
            Choice("Eat the cake") {
                SimplePassage("You take a bite of the piece of cake you carefully cut. It is magnificent! You finish the first piece but still feel compelled to another... and another.. until the whole cake is gone. Unfortunately, you experience death by chocolate.")
            }
            Choice("Don't eat the cake") {
                SimplePassage("Nice of you to not eat someone else's cake. You're so nice in fact that you take to tidying up the kitchen. Unfortunately, while washing the floor you slip and bang your head on the corner of the counter. You die from loss of blood. Never pays to be nice, eh?")
            }
        }
        .withImage(URL(string: "testImage"))
        .addingTextSection("make a good choice")
    }
}
)

story.foreachAction { passage in
    print(formattedPassage(passage), terminator: "\n")
    passage.actions.keys.forEach { (action) in
        print(">>> \(action)", terminator: "\n")
    }
    print("-----------------------------------------")
    
    if !passage.actions.isEmpty {
        let userInputAction = findValidUserInput(forActions: Array(passage.actions.keys))
        passage.goAhead(action: userInputAction)
    }
}

