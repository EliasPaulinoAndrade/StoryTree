//
//  StoryTreeWithCombineTests.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 26/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

//import XCTest
//import StoryTree
//import Combine
//@testable import StoryTreeiOS
//
//class StoryTreeWithCombineTests: XCTestCase {
//    var cancellablesStore: [AnyCancellable] = []
//
//    override func tearDown() {
//        cancellablesStore = []
//    }
//
//    func test_sinkForeachActionWithOnePassage_isCalledForRootPassage() {
//        let storyTree = MockStoryTree(option: .onePassage)
//        let actionExpectation = expectation(description: "root passage action was called")
//        let wantedPassages: [SimplePassage] = [storyTree.rootSimplePassage]
//
//        checkPublisherSequence(publisher: storyTree.foreachSimplePassageAction, toBeEqualTo: wantedPassages, storeIn: &cancellablesStore) {
//            actionExpectation.fulfill()
//        }
//
//        wait(for: [actionExpectation], timeout: 1)
//    }
//
//    func test_sinkForeachActionWithTwoPassage_isCalledForRootAndSecondPassage() {
//        let storyTree = MockStoryTree(option: .multiplePassages)
//        let actionExpectation = expectation(description: "root passage action was called")
//        let wantedPassages: [SimplePassage] = [storyTree.rootSimplePassage, storyTree.secondSimplePassage]
//
//        checkPublisherSequence(publisher: storyTree.foreachSimplePassageAction, toBeEqualTo: wantedPassages, storeIn: &cancellablesStore) {
//            actionExpectation.fulfill()
//        }
//
//        storyTree.goAhead(action: "choice1")
//
//        wait(for: [actionExpectation], timeout: 1)
//
//    }
//
//    func test_sinkForeachAfterCallingGoAhead_passagesReturnsTheLastValue() {
//        let storyTree = MockStoryTree(option: .multiplePassages)
//        let actionExpectation = expectation(description: "root passage action was called for second passage")
//        let wantedPassages: [SimplePassage] = [storyTree.secondSimplePassage]
//
//        storyTree.goAhead(action: "choice1")
//
//        checkPublisherSequence(publisher: storyTree.foreachSimplePassageAction, toBeEqualTo: wantedPassages, storeIn: &cancellablesStore) {
//            actionExpectation.fulfill()
//        }
//
//        wait(for: [actionExpectation], timeout: 1)
//    }
//}
//
//extension StoryTree {
//    var foreachSimplePassageAction: Publishers.CompactMap<CurrentValueSubject<Passage, Never>, SimplePassage> {
//        return foreachAction.compactMap({ $0 as? SimplePassage })
//    }
//
//    var rootSimplePassage: SimplePassage {
//        return rootPassage as! SimplePassage
//    }
//
//    var secondSimplePassage: SimplePassage {
//        return rootSimplePassage.actions["choice1"] as! SimplePassage
//    }
//}
