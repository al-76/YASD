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

func createContainer() -> Container {
    let container = Container()
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
        LexinServiceParameters(language: LexinServiceParameters.defaultLanguage) }
        .inObjectScope(.container)
    container.register(LexinService.self) { _ in
        LexinService(network: container.resolve(Network.self)!,
                     htmlParser: container.resolve(HtmlParser.self)!,
                     parameters: container.resolve(LexinServiceParameters.self)!,
                     formatter: container.resolve(LexinServiceFormatter.self)!) }
        .inObjectScope(.container)
    
    // Models
    container.register(WordsViewModel.self) { container in
        WordsViewModel(lexin: container.resolve(LexinService.self)!) }
        .inObjectScope(.container)
    container.register(SettingsViewModel.self) { container in
        SettingsViewModel(lexinParameters: container.resolve(LexinServiceParameters.self)!) }
        .inObjectScope(.container)
    container.register(SettingsLanguageViewModel.self) { container in
        SettingsLanguageViewModel(lexinParameters: container.resolve(LexinServiceParameters.self)!) }
        .inObjectScope(.container)
    
    // View
    container.storyboardInitCompleted(WordsTableViewController.self) { container, view in
        view.model = container.resolve(WordsViewModel.self)
    }
    container.storyboardInitCompleted(SettingsTableViewController.self) { container, view in
        view.model = container.resolve(SettingsViewModel.self)
    }
    container.storyboardInitCompleted(SettingsLanguageTableViewController.self) { container, view in
        view.model = container.resolve(SettingsLanguageViewModel.self)
    }
    return container
}
