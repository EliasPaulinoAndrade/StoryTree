//
//  AppDelegate.swift
//  StoryTreeiOS
//
//  Created by Elias Paulino on 25/01/20.
//  Copyright © 2020 Elias Paulino. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIViewController() ?? ChatViewController(viewModel: DefaultChatViewModel(
            repository: DefaultStoryTreeRepository(),
            ballonViewModelInjector: { text -> PassageViewModel in
                return DefaultBallonViewModel(text: text)
            }
        ))
        window?.makeKeyAndVisible()
        return true
    }
}

