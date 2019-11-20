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
    func registerForStoryboard<C: UIViewController>(_ serviceType: C.Type,
                                                    withIdentifier identifier : String,
                                                    registered: @escaping (Swinject.Resolver, C) -> ()) {
        register(serviceType.self) { container in
            let storyboard = container.resolve(SwinjectStoryboard.self)!
            let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! C
            registered(container, viewController)
            return viewController
        }
    }
}

extension SwinjectStoryboard {
    class func register(storyboard: SwinjectStoryboard, container: Container) {
        container.register(SwinjectStoryboard.self) { container in
            storyboard
        }
        .inObjectScope(.container)
    }
}
