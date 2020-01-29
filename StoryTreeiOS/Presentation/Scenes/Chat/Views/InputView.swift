//
//  InputView.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 28/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import UIKit
import Twiner

class InputView: UIView, ViewCodable {
    private var viewModel: InputViewModel
    
    let inputLabel = UILabel()
    let inputButton = UIButton().build {
        $0.addTarget(self, action: #selector(buttonWasTapped), for: .touchUpInside)
    }
    
    init(viewModel: InputViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonWasTapped() {
        guard let labelText = inputLabel.text else {
            return
        }
        viewModel.input.message.send(labelText)
    }
    
    func buildHierarchy() {
        self.addSubview(inputLabel)
        self.addSubview(inputButton)
    }
}
