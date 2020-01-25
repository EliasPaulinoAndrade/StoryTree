//
//  UITableView+dequeueReusableCell+registerReusableCell.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<CellType: UITableViewCell>(forCellType cellType: CellType.Type, for indexPath: IndexPath) -> CellType {
        let cellIdentifier = String(describing: cellType)
        
        guard let dequeuedCell = self.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CellType else {
            fatalError("""
                No table view cell registered for the type: \(cellIdentifier) and
                IndexPath: \(indexPath)
            """)
        }
        
        return dequeuedCell
    }
    
    func registerReusableCell<CellType: UITableViewCell>(forCellType cellType: CellType.Type) {
        let cellIdentifier = String(describing: cellType)
        self.register(CellType.self, forCellReuseIdentifier: cellIdentifier)
    }
}
