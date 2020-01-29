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
    
    let descriptionLabel: UILabel = UILabel().build {
        $0.numberOfLines = 0
    }
    
    let ballonBackgroundView = UIView().build {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func buildHierarchy() {
        addSubview(ballonBackgroundView)
        ballonBackgroundView.addSubview(descriptionLabel)
    }
     
    func addConstraints() {
        ballonBackgroundView.layout.build {
            $0.group.top.left.bottom.fill(to: layoutMarginsGuide)
            $0.right.lessThanOrEqual(to: layoutMarginsGuide.layout.right)
        }
        descriptionLabel.layout.fillSuperView(withMargin: 10)
    }
    
    func applyAditionalChanges() {
        backgroundColor = .clear
    }
}
