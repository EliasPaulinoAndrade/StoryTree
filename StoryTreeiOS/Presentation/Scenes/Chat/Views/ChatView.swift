//
//  ChatView.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 29/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import UIKit

class ChatView: UIView, ViewCodable {
    private var viewModel: ChatViewModel
    lazy var messagesView = MessagesView(viewModel: viewModel.output.messagesViewModel)
    lazy var messagesInputView = InputView(viewModel: viewModel.output.inputViewModel)
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        addSubview(messagesView)
        addSubview(messagesInputView)
    }
}
