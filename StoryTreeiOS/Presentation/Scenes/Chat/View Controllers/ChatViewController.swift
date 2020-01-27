//
//  ChatViewController.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 26/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import UIKit
import Twiner

class ChatViewController: UIViewController, ViewCodable {
    lazy var chatView = ChatView(viewModel: viewModel)
    
    private let viewModel: ChatViewModel
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        view.addSubview(chatView)
    }
    
    func addConstraints() {
        chatView.layout.fill(view: view.layoutMarginsGuide)
    }
}
