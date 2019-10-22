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
    container.register(Files.self) { _ in Files() }
        .inObjectScope(.container)
    container.register(Player.self) { _ in Player() }
        .inObjectScope(.container)
    container.register(DataCache.self) { _, name in DataCache(name: name) }
}

func configureService(container: Container) {
    // Parsers
    container.register(LexinServiceParserDefault.self) { _ in
        LexinServiceParserDefault(htmlParser: container.resolve(HtmlParser.self)!)
    }
    .inObjectScope(.container)
    container.register(LexinServiceParserFolkets.self) { _ in
        LexinServiceParserFolkets(htmlParser: container.resolve(HtmlParser.self)!)
    }
    .inObjectScope(.container)
    container.register(LexinServiceParserSwedish.self) { _ in
        LexinServiceParserSwedish(htmlParser: container.resolve(HtmlParser.self)!)
    }
    .inObjectScope(.container)
    container.register(LexinSuggestionParserDefault.self) { _ in
        LexinSuggestionParserDefault()
    }
    .inObjectScope(.container)
    container.register(LexinSuggestionParserFolkets.self) { _ in
        LexinSuggestionParserFolkets()
    }
    .inObjectScope(.container)
    
    // Formatter
    container.register(LexinServiceFormatter.self) { _ in
        LexinServiceFormatter(markdown: container.resolve(Markdown.self)!)
        
    }
    .inObjectScope(.container)
    
    // Parameters
    container.register(LexinServiceParameters.self) { _ in
        LexinServiceParameters(storage: container.resolve(Storage.self)!,
                               language: LexinServiceParameters.defaultLanguage)
    }
    .inObjectScope(.container)
    
    // Providers
    container.register(LexinServiceProviderWords.self) { _ in
        LexinServiceProviderWords(defaultParser: container.resolve(LexinServiceParserDefault.self)!, folketsParser: container.resolve(LexinServiceParserFolkets.self)!, swedishParser: container.resolve(LexinServiceParserSwedish.self)!)
    }
    .inObjectScope(.container)
    container.register(LexinServiceProviderSuggestion.self) { _ in
        LexinServiceProviderSuggestion(defaultParser: container.resolve(LexinSuggestionParserDefault.self)!, folketsParser: container.resolve(LexinSuggestionParserFolkets.self)!, swedishParser: container.resolve(LexinSuggestionParserDefault.self)!)
    }
    .inObjectScope(.container)
    
    // Cache Service
    container.register(CacheService.self) { _ in
        CacheService(cache: container.resolve(DataCache.self, argument: "CacheService")!)
    }
    .inObjectScope(.container)
    
    // Player Service
    container.register(PlayerService.self) { _ in
        PlayerService(player: container.resolve(Player.self)!,
                      cache: container.resolve(CacheService.self)!,
                      network: container.resolve(Network.self)!)
    }
    .inObjectScope(.container)
    
    // Cache Network Service
    container.register(NetworkService.self) { _ in
        NetworkService(cache: container.resolve(CacheService.self)!,
        network: container.resolve(Network.self)!)
    }
    .inObjectScope(.container)
    
    // Lexin Service
    container.register(LexinServiceSuggestion.self) { _ in
        LexinServiceSuggestion(network: container.resolve(NetworkService.self)!)
    }
    .inObjectScope(.container)
    container.register(LexinService.self) { _ in
        LexinService(network: container.resolve(NetworkService.self)!,
                     parameters: container.resolve(LexinServiceParameters.self)!,
                     provider: container.resolve(LexinServiceProviderWords.self)!)
    }
    .inObjectScope(.container)
    container.register(FormattedLexinService.self) { _ in
        FormattedLexinService(service: container.resolve(LexinService.self)!,
                              formatter: container.resolve(LexinServiceFormatter.self)!)
    }
    .inObjectScope(.container)
}

func configureModel(container: Container) {
    container.register(WordsSuggestionViewModel.self) { container in
        WordsSuggestionViewModel(suggestion: container.resolve(LexinServiceSuggestion.self)!)
    }
    .inObjectScope(.container)
    
    container.register(WordsViewModel.self) { container in
        WordsViewModel(lexin: container.resolve(FormattedLexinService.self)!,
                       player: container.resolve(PlayerService.self)!)
    }
    .inObjectScope(.container)
    
    container.register(SettingsViewModel.self) { container in
        SettingsViewModel(lexinParameters: container.resolve(LexinServiceParameters.self)!)
        
    }
    .inObjectScope(.container)
    
    container.register(SettingsLanguageViewModel.self) { container in
        SettingsLanguageViewModel(lexinParameters: container.resolve(LexinServiceParameters.self)!)
    }
    .inObjectScope(.container)
}

func configureView(container: Container) {
    container.registerForStoryboard(WordsSuggestionTableViewController.self,
                                    withIdentifier: "WordsSuggestionTableViewController") { container, view  in
        view.model = container.resolve(WordsSuggestionViewModel.self)!
    }
    container.storyboardInitCompleted(WordsTableViewController.self) { container, view in
        view.model = container.resolve(WordsViewModel.self)
        view.searchResultsController = container.resolve(WordsSuggestionTableViewController.self)
    }
    container.storyboardInitCompleted(SettingsTableViewController.self) { container, view in
        view.model = container.resolve(SettingsViewModel.self)
    }
    container.storyboardInitCompleted(SettingsLanguageTableViewController.self) { container, view in
        view.model = container.resolve(SettingsLanguageViewModel.self)
    }
}
