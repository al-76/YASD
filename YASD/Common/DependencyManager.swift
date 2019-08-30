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
    
    configurePlatform(container: container)
    configureService(container: container)
    configureModel(container: container)
    configureView(container: container)
    
    return container
}

func configurePlatform(container: Container) {
    container.register(Network.self) { _ in Network() }
        .inObjectScope(.container)
    container.register(HtmlParser.self) { _ in HtmlParser() }
        .inObjectScope(.container)
    container.register(Markdown.self) { _ in Markdown() }
        .inObjectScope(.container)
    container.register(Storage.self) { _ in Storage() }
        .inObjectScope(.container)
}

func configureService(container: Container) {
    // Parsers
    container.register(LexinServiceParserDefault.self) { _ in
        LexinServiceParserDefault(htmlParser: container.resolve(HtmlParser.self)!)
        }.inObjectScope(.container)
    container.register(LexinServiceParserFolkets.self) { _ in
        LexinServiceParserFolkets(htmlParser: container.resolve(HtmlParser.self)!)
        }.inObjectScope(.container)
    container.register(LexinServiceParserSwedish.self) { _ in
        LexinServiceParserSwedish(htmlParser: container.resolve(HtmlParser.self)!)
        }.inObjectScope(.container)

    // Formatter
    container.register(LexinServiceFormatter.self) { _ in
        LexinServiceFormatter(markdown: container.resolve(Markdown.self)!) }
        .inObjectScope(.container)
    // Parameters
    container.register(LexinServiceParameters.self) { _ in
        LexinServiceParameters(storage: container.resolve(Storage.self)!,
                               language: LexinServiceParameters.defaultLanguage) }
        .inObjectScope(.container)
    // Provider
    container.register(LexinServiceProvider.self) { _ in
        LexinServiceProvider(defaultParser: container.resolve(LexinServiceParserDefault.self)!,
                             folketsParser: container.resolve(LexinServiceParserFolkets.self)!,
                             swedishParser: container.resolve(LexinServiceParserSwedish.self)!)
        }
        .inObjectScope(.container)
    // Lexin Service
    container.register(LexinService.self) { _ in
        LexinService(network: container.resolve(Network.self)!,
                     parameters: container.resolve(LexinServiceParameters.self)!,
                     formatter: container.resolve(LexinServiceFormatter.self)!,
                     provider: container.resolve(LexinServiceProvider.self)!) }
        .inObjectScope(.container)
}

func configureModel(container: Container) {
    container.register(WordsViewModel.self) { container in
        WordsViewModel(lexin: container.resolve(LexinService.self)!) }
        .inObjectScope(.container)
    container.register(SettingsViewModel.self) { container in
        SettingsViewModel(lexinParameters: container.resolve(LexinServiceParameters.self)!) }
        .inObjectScope(.container)
    container.register(SettingsLanguageViewModel.self) { container in
        SettingsLanguageViewModel(lexinParameters: container.resolve(LexinServiceParameters.self)!) }
        .inObjectScope(.container)
}

func configureView(container: Container) {
    container.storyboardInitCompleted(WordsTableViewController.self) { container, view in
        view.model = container.resolve(WordsViewModel.self)
    }
    container.storyboardInitCompleted(SettingsTableViewController.self) { container, view in
        view.model = container.resolve(SettingsViewModel.self)
    }
    container.storyboardInitCompleted(SettingsLanguageTableViewController.self) { container, view in
        view.model = container.resolve(SettingsLanguageViewModel.self)
    }
}
