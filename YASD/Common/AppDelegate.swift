//
//  AppDelegate.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Firebase
import Swinject
import SwinjectStoryboard
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let container = { () -> Container in
        createContainer()
    }()

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = createMainWindow(container)
        return true
    }

    func application(_ application: UIApplication, continue _: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        let indexVC = 1
        guard let tabBar = application.keyWindow?.rootViewController as? UITabBarController,
              let navVC = tabBar.viewControllers?[indexVC] as? UINavigationController,
              let bookmarksVC = navVC.viewControllers.first as? BookmarksTableViewController
        else {
            return false
        }
        tabBar.selectedIndex = indexVC
        restorationHandler([bookmarksVC])
        return true
    }

    func createMainWindow(_ container: Container) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = createRootViewController(container)
        return window
    }

    func createRootViewController(_ container: Container) -> UIViewController? {
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
        SwinjectStoryboard.register(storyboard, with: container)
        return storyboard.instantiateInitialViewController()
    }
}
