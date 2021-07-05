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
                                                    withIdentifier identifier: String,
                                                    registered: @escaping (Swinject.Resolver, C) -> Void) {
        register(serviceType.self) { container in
            let storyboard = container.resolve(SwinjectStoryboard.self)!
            let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? C
            if let vc = viewController {
                registered(container, vc)
            }
            return viewController!
        }
    }
}

extension SwinjectStoryboard {
    class func register(_ storyboard: SwinjectStoryboard, with container: Container) {
        container.register(SwinjectStoryboard.self) { _ in
            storyboard
        }
        .inObjectScope(.container)
    }
}
