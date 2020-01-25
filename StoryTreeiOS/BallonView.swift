//
//  BallonView.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import UIKit

class BallonView: UIView {
    var viewModel: PassageViewModel? {
        didSet {
            guard let viewModel = self.viewModel else {
                return
            }
            textLabel.text = viewModel.text
        }
    }
    let textLabel: UILabel = UILabel()
}

protocol PassageViewModel {
    var text: String { get }
}
