//
//  TableViewCombiner.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 28/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import XCTest
@testable import StoryTreeiOS

class TableViewOperatorTests: XCTestCase {
    func teste_reloadCollectionWithInteger_reloadsTableView() {
        let tableView = UITableView()
        let tableOperator = TableViewOperator(tableView, configurator: CellConfigurator { (cell, position, element: Int) in } )
        
        tableOperator.reloadCollection([1, 2, 3])
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 3)
    }
    
    func teste_reloadCollectionWithString_reloadsTableView() {
        let tableView = UITableView()
        let tableOperator = TableViewOperator(tableView, configurator: CellConfigurator { (cell, position, element: String) in } )
        
        tableOperator.reloadCollection(["1", "2", "3"])
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 3)
    }
    
    func test_reloadCollection_tableViewHasTheCorrectCells() {
        let tableView = UITableView()
        let tableOperator = TableViewOperator(tableView, configurator:
            CellConfigurator { (cell, position, element: String) in
                cell.textLabel?.text = element
            }
        )
        tableOperator.reloadCollection(["1", "2", "3"])
        XCTAssertEqual(tableView.textLabelValuesFor(positions: [0, 1, 2]), ["1", "2", "3"])
    }
    
    func test_reloadCollection_tableViewHasTheCorrectCustomCells() {
        let tableView = UITableView()
        let tableOperator = TableViewOperator(tableView, configurator:
            CellConfigurator { (cell: CustomMockCell, position, element: String) in
                cell.textLabel?.text = element
            }
        )

        tableOperator.reloadCollection(["1", "2", "3"])
        XCTAssertTrue(tableView.checkCellTypesFor(positions: [0, 1, 2], equalTo: CustomMockCell.self))
        XCTAssertEqual(tableView.textLabelValuesFor(positions: [0, 1, 2]), ["1", "2", "3"])
    }
    
    func test_reloadCollection_withTapObserver() {
        let tableView = UITableView()
        let tapExpectation = expectation(description: "cell was tapped")
        let tableOperator = TableViewOperator(tableView, configurator: CellConfigurator { (cell: CustomMockCell, position, element: String) in })
            .with(TapObserver{ position in
                XCTAssertEqual(position, 0)
                tapExpectation.fulfill()
            })
        tableOperator.reloadCollection(["1", "2", "3"])
        tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        wait(for: [tapExpectation], timeout: 1)
    }
}
