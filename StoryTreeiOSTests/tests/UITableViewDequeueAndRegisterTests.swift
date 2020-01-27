//
//  UITableViewDequeueAndRegisterTests.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
@testable import StoryTreeiOS

class UITableViewDequeueAndRegisterTests: XCTestCase {
    func test_registerTwoCellsByClass_registerThemByTheName() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.registerReusableCell(forCellType: UITableViewCell.self)
        tableView.registerReusableCell(forCellType: MockTableViewCell.self)
        
        let registeredCells = tableView.value(forKey: "_cellClassDict") as? [String: Any]
        
        XCTAssertTrue(registeredCells?.keys.contains("UITableViewCell") ?? false)
        XCTAssertTrue(registeredCells?.keys.contains("MockTableViewCell") ?? false)
    }
    
    func test_dequeueCellWithCorrectIdentifier_returnsTheCorrectCell() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.registerReusableCell(forCellType: MockTableViewCell.self)
        
        let mockCell = tableView.dequeueReusableCell(
            forCellType: MockTableViewCell.self,
            for: IndexPath(row: 0, section: 0)
        )
        
        XCTAssertNotNil(mockCell)
    }
}

class MockTableViewCell: UITableViewCell { }
