//
//  Swinject+Extensions.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 11/10/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension Container {
    func registerForStoryboard<C: UIViewController>(_ serviceType: C.Type, withIdentifier identifier : String, registered: @escaping (Swinject.Resolver, C) -> ()) {
        register(serviceType.self) { container in
            let storyboard = container.resolve(SwinjectStoryboard.self)!
            let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! C
            registered(container, viewController)
            return viewController
        }
    }
}

extension SwinjectStoryboard {
    class func getStoryboard(name: String, bundle storyboardBundleOrNil: Bundle?, container: Container) -> SwinjectStoryboard {
        if let storyboard = container.resolve(SwinjectStoryboard.self) {
            return storyboard
        }
        
        let storyboard = SwinjectStoryboard.create(name: name, bundle: storyboardBundleOrNil, container: container)
        container.register(SwinjectStoryboard.self) { container in
            storyboard
        }
        .inObjectScope(.container)
        return storyboard
    }
}
