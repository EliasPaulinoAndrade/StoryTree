//
//  UITableView+.swift
//  StoryTreeiOSTests
//
//  Created by Elias Paulino on 28/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import UIKit

extension UITableView {
    func textLabelValuesFor(positions: [Int]) -> [String] {
        return positions.compactMap { (position) -> String? in
            return dataSource?.tableView(self, cellForRowAt: IndexPath(row: position, section: 0)).textLabel?.text
        }
    }
    
    func checkCellTypesFor<CellType: UITableViewCell>(positions: [Int], equalTo: CellType.Type) -> Bool {
        return positions.allSatisfy { (position) -> Bool in
            return dataSource?.tableView(self, cellForRowAt: IndexPath(row: position, section: 0)) is CellType
        }
    }
}
