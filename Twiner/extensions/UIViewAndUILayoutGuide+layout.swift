//
//  UIViewAndUILayoutGuide+proxy.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

extension UIView: Anchorable {
    public var layout: LayoutProxy {
        self.translatesAutoresizingMaskIntoConstraints = false
        return LayoutProxy(anchorable: self)
    }
    
    public var frameLayout: LayoutProxy {
        return LayoutProxy(anchorable: self)
    }
}

extension UILayoutGuide: Anchorable {
    public var layout: LayoutProxy {
        return LayoutProxy(anchorable: self)
    }
}
