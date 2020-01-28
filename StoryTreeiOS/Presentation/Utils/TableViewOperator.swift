//
//  TableViewOperator.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 28/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import UIKit

struct CellConfigurator<CellType: UITableViewCell, Element> {
    lazy var configure = configurationBlock
    var configurationBlock: (_ cell: CellType, _ position: Int, _ element: Element) -> Void
}

class TableViewOperator<CellType: UITableViewCell, Element>: NSObject, UITableViewDataSource {
    private weak var tableView: UITableView?
    private var configurator: CellConfigurator<CellType, Element>
    private var collection: [Element] = []
    
    init(tableView: UITableView, configurator: CellConfigurator<CellType, Element>) {
        self.tableView = tableView
        self.configurator = configurator
        
        super.init()
        
        tableView.dataSource = self
        tableView.registerReusableCell(forCellType: CellType.self)
    }
    
    func reloadCollection(_ collection: [Element]) {
        self.collection = collection
        tableView?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forCellType: CellType.self, for: indexPath)
        
        configurator.configure(cell, indexPath.row, collection[indexPath.row])
        
        return cell
    }
}

@_functionBuilder
struct TableOperatorBuilder {
    static func buildBlock<CellType: UITableViewCell, Element>(_ segment: CellConfigurator<CellType, Element>) -> CellConfigurator<CellType, Element> {
        return segment
    }
}

extension TableViewOperator {
    convenience init(_ tableView: UITableView, @TableOperatorBuilder _ content: () -> CellConfigurator<CellType, Element>) {
        self.init(tableView: tableView, configurator: content())
    }
}
