//
//  DependencyManager.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 29/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

func configure(container: Container) {
    // Platform
    container.register(Network.self) { _ in Network() }
        .inObjectScope(.container)
    container.register(HtmlParser.self) { _ in HtmlParser() }
        .inObjectScope(.container)
    container.register(Markdown.self) { _ in Markdown() }
        .inObjectScope(.container)
    
    // Services
    container.register(LexinServiceFormatter.self) { _ in
        LexinServiceFormatter(markdown: container.resolve(Markdown.self)!) }
        .inObjectScope(.container)
    container.register(LexinServiceParameters.self) { _ in
        LexinServiceParameters(from:"swe", to:"rus") }
        .inObjectScope(.container)
    container.register(LexinService.self) { _ in
        LexinService(network: container.resolve(Network.self)!,
                     htmlParser: container.resolve(HtmlParser.self)!,
                     parameters: container.resolve(LexinServiceParameters.self)!,
                     formatter: container.resolve(LexinServiceFormatter.self)!) }
        .inObjectScope(.container)
    
    // Models
    container.register(WordsTableViewModel.self) { container in
        WordsTableViewModel(lexin: container.resolve(LexinService.self)!) }
        .inObjectScope(.container)
    
    // View
    container.storyboardInitCompleted(WordsTableViewController.self) { container, view in
        view.model = container.resolve(WordsTableViewModel.self)
    }
}
