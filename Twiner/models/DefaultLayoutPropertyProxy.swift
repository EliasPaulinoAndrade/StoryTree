//
//  DefaultLayoutPropertyProxy.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// A type to make possible have references to a LayoutPropertyProxy.
public struct DefaultLayoutPropertyProxy<AnchorType: AnyObject>: LayoutPropertyProxy {
    public var type: LayoutPropertyProxyType
    public var layout: LayoutProxy
    public var anchor: NSLayoutAnchor<AnchorType>
    
    public init(anchor: NSLayoutAnchor<AnchorType>, layout: LayoutProxy, type: LayoutPropertyProxyType) {
        self.layout = layout
        self.anchor = anchor
        self.type = type
    }
}
