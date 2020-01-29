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

struct TapObserver {
    var tapHandleBlock: (_ position: Int) -> Void
}

class TableViewOperator<CellType: UITableViewCell, Element>: NSObject, UITableViewDataSource, UITableViewDelegate {
    private weak var tableView: UITableView?
    private var configurator: CellConfigurator<CellType, Element>
    private var tapObserver: TapObserver?
    private var collection: [Element] = []
    
    init(_ tableView: UITableView, configurator: CellConfigurator<CellType, Element>, tapObserver: TapObserver? = nil) {
        self.tableView = tableView
        self.configurator = configurator
        self.tapObserver = tapObserver
        
        super.init()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerReusableCell(forCellType: CellType.self)
    }
    
    func with(_ tapObserver: TapObserver) -> TableViewOperator {
        self.tapObserver = tapObserver
        return self
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tapObserver?.tapHandleBlock(indexPath.row)
    }
}
