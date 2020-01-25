//
//  BallonView.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import UIKit
import Twiner

class BallonView: UITableViewCell, ViewCodable {
    var viewModel: PassageViewModel? {
        didSet {
            guard let viewModel = self.viewModel else {
                return
            }
            descriptionLabel.text = viewModel.text
        }
    }
    
    let descriptionLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func buildHierarchy() {
        self.addSubview(descriptionLabel)
    }
     
    func addConstraints() {
        descriptionLabel.layout.fillSuperView()
    }
}
