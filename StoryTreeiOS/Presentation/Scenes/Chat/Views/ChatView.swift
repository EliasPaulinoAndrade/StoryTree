//
//  ChatView.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import UIKit
import Combine

class ChatView: UITableView, ViewCodable {
    private var viewModel: ChatViewModel
    private var cancellableStore: [AnyCancellable] = []
    
    public var numberOfShowedItems: Int {
        return self.numberOfRows(inSection: 0)
    }
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ballonCellAt(position: Int) -> BallonView? {
        self.cellForRow(at: IndexPath(row: position, section: 0)) as? BallonView
    }
    
    func observeViewModel() {
        self.endUpdates()
        
        viewModel.output.messageWasAdded.sink { [weak self] _ in
            ifIsSafe(self) { (self) in
                if self.numberOfShowedItems == 0 {
                    DispatchQueue.main.async {
                        self.reloadData()
                        self.endUpdates()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.insertRows(at: [.init(row: self.numberOfShowedItems, section: 0)], with: .bottom)
                        self.endUpdates()
                    }
                }
            }
        }.store(in: &cancellableStore)        
    }
    
    func applyAditionalChanges() {
        self.dataSource = self
        self.registerReusableCell(forCellType: BallonView.self)
    }
    
    override func didMoveToSuperview() {
        setupView()
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
