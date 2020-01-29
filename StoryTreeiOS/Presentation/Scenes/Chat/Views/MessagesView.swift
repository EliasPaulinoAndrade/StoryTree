//
//  MessagesView.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import UIKit
import Combine

class MessagesView: UITableView, ViewCodable {
    private var viewModel: MessagesViewModel
    private var cancellableStore: [AnyCancellable] = []
    private lazy var tableOperator = TableViewOperator(self,
        configurator: CellConfigurator { (cell: BallonView, position, element: PassageViewModel) in
            cell.viewModel = element
        }
    )
    
    public var numberOfShowedItems: Int {
        return self.numberOfRows(inSection: 0)
    }
        
    init(viewModel: MessagesViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, style: .plain)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ballonCellAt(position: Int) -> BallonView? {
        self.cellForRow(at: IndexPath(row: position, section: 0)) as? BallonView
    }

    func observeViewModel() {
        viewModel.output.messages.sink { messages in
            self.tableOperator.reloadCollection(messages)
        }.store(in: &cancellableStore)
    }
    
    func applyAditionalChanges() {
        separatorStyle = .none
        backgroundColor = .clear
    }
}
