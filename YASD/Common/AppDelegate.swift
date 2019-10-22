//
//  AppDelegate.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let container = { () -> Container in
        return createContainer()
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = createMainWindow(container: container)
        
        return true
    }
    
    func createMainWindow(container: Container) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = createRootViewController(container: container)
        return window
    }
    
    func createRootViewController(container: Container) -> UIViewController? {
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
        SwinjectStoryboard.register(storyboard: storyboard, container: container)
        return storyboard.instantiateInitialViewController()
    }
}

