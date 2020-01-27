//
//  Injector.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 26/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import Foundation

typealias Injector<Injected, Data> = (Data) -> Injected
