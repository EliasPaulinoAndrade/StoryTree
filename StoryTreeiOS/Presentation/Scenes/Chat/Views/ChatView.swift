//
//  ChatView.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import UIKit

class ChatView: UITableView, ViewCodable {
    private var viewModel: ChatViewModel
    
    public var numberOfShowedItems: Int {
        return self.numberOfRows(inSection: 0)
    }
    
    init(viewModel: ChatViewModel) {
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
        viewModel.output.showNewMessage = { [weak self] viewModel in
            ifIsSafe(self) { (self) in
                if self.numberOfShowedItems == 0 {
                    self.reloadData()
                } else {
                    self.insertRows(at: [.init(row: self.numberOfShowedItems, section: 0)], with: .bottom)
                }
            }
        }
    }
    
    func applyAditionalChanges() {
        self.dataSource = self
        self.registerReusableCell(forCellType: BallonView.self)
    }
}

extension ChatView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.numberOfMessages
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ballonView = tableView.dequeueReusableCell(forCellType: BallonView.self, for: indexPath)
        ballonView.viewModel = viewModel.output.ballonViewModelAt(indexPath.row)
        return ballonView
    }
}
