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
    
    configurePlatform(container)
    configureService(container)
    configureApi(container)
    configureModel(container)
    configureView(container)
    
    return container
}

func configurePlatform(_ container: Container) {
    container.register(Network.self) { _ in Network() }
        .inObjectScope(.container)
    container.register(HtmlParser.self) { _ in HtmlParser() }
        .inObjectScope(.container)
    container.register(Markdown.self) { _ in Markdown() }
        .inObjectScope(.container)
    container.register(Storage.self) { _ in Storage() }
        .inObjectScope(.container)
    container.register(Player.self) { _ in Player() }
        .inObjectScope(.container)
    container.register(DataCache.self) { _, name in DataCache(name: name) }
    container.register(ExternalCacheService.self) { _ in Spotlight() }
        .inObjectScope(.container)
}

func configureApi(_ container: Container) {
    // Api
    container.register(LexinApi.self, name: "LexinApi") { _ in
        LexinApi(network: container.resolve(NetworkService.self)!, parserWords: container.resolve(LexinParserWordsDefault.self)!, parserSuggestions: container.resolve(LexinParserSuggestionDefault.self)!)
    }
    container.register(LexinApi.self, name: "LexinApiSwedish") { _ in
        LexinApi(network: container.resolve(NetworkService.self)!, parserWords: container.resolve(LexinParserWordsSwedish.self)!, parserSuggestions: container.resolve(LexinParserSuggestionDefault.self)!)
    }
    container.register(LexinApi.self, name: "LexinApiFolkets") { _ in
        LexinApi(network: container.resolve(NetworkService.self)!, parserWords: container.resolve(LexinParserWordsFolkets.self)!, parserSuggestions: container.resolve(LexinParserSuggestionFolkets.self)!)
    }
    // Provider
    container.register(LexinApiProvider.self) { _ in
        LexinApiProvider(defaultApi: container.resolve(LexinApi.self, name: "LexinApi")!,
                         folketsApi: container.resolve(LexinApi.self, name: "LexinApiFolkets")!,
                         swedishApi: container.resolve(LexinApi.self, name: "LexinApiSwedish")!)
    }
    .inObjectScope(.container)
}

func configureService(_ container: Container) {
    // Parsers
    container.register(LexinParserWordsDefault.self) { _ in
        LexinParserWordsDefault(htmlParser: container.resolve(HtmlParser.self)!)
    }
    .inObjectScope(.container)
    container.register(LexinParserWordsFolkets.self) { _ in
        LexinParserWordsFolkets(htmlParser: container.resolve(HtmlParser.self)!)
    }
    .inObjectScope(.container)
    container.register(LexinParserWordsSwedish.self) { _ in
        LexinParserWordsSwedish(htmlParser: container.resolve(HtmlParser.self)!)
    }
    .inObjectScope(.container)
    container.register(LexinParserSuggestionDefault.self) { _ in
        LexinParserSuggestionDefault()
    }
    .inObjectScope(.container)
    container.register(LexinParserSuggestionFolkets.self) { _ in
        LexinParserSuggestionFolkets()
    }
    .inObjectScope(.container)
    
    // Formatter
    container.register(LexinServiceFormatter.self) { _ in
        LexinServiceFormatter(markdown: container.resolve(Markdown.self)!)
    }
    .inObjectScope(.container)
    
    // Parameters
    container.register(ParametersStorage.self) { _ in
        ParametersStorage(storage: container.resolve(Storage.self)!,
                               language: ParametersStorage.defaultLanguage)
    }
    .inObjectScope(.container)
    
    // Cache Service
    container.register(CacheService.self) { _ in
        CacheService(cache: container.resolve(DataCache.self, argument: "CacheService")!)
    }
    .inObjectScope(.container)
    
    // Player Service
    container.register(PlayerManager.self) { _ in
        DefaultPlayerManager(player: container.resolve(Player.self)!,
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
    
    // Lexin Dictionary Service
    container.register(LexinDictionaryService.self) { _ in
        LexinDictionaryService(parameters: container.resolve(ParametersStorage.self)!,
                               provider: container.resolve(LexinApiProvider.self)!,
                               mapper: container.resolve(LexinWordMapper.self)!)
    }
    
    // WordsService
    container.register(WordsService.self) { _ in
        container.resolve(LexinDictionaryService.self)!
    }
    .inObjectScope(.container)
    
    // SuggestionService
    container.register(SuggestionService.self) { _ in
        container.resolve(LexinDictionaryService.self)!
    }
    .inObjectScope(.container)
    
    // Storage Service
    container.register(AnyStorageRepository<Suggestion>.self) { _ in
        AnyStorageRepository(wrapped: DefaultStorageRepository<Suggestion>(id: "history", storage: container.resolve(Storage.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyStorageRepository<FormattedWord>.self) { _ in
        AnyStorageRepository(wrapped: DefaultStorageRepository<FormattedWord>(id: "bookmarks", storage: container.resolve(Storage.self)!))
    }
    .inObjectScope(.container)
    
    container.register(AnyStorageRepository<Suggestion>.self) { _ in
        AnyStorageRepository(wrapped: DefaultStorageRepository<Suggestion>(id: "history", storage: container.resolve(Storage.self)!))
    }
    
    // Lexin Word Mapper
    container.register(LexinWordMapper.self) { _ in
        LexinWordMapper(formatter: container.resolve(LexinServiceFormatter.self)!,
                     bookmarks: container.resolve(AnyStorageRepository<FormattedWord>.self)!)
    }
    .inObjectScope(.container)
    
    // Language Settings Service
    container.register(SettingsLanguageService.self) { _ in
        DefaultSettingsLanguageService(parameters: container.resolve(ParametersStorage.self)!)
    }
    .inObjectScope(.container)
}

func configureModel(_ container: Container) {
    container.register(WordsSuggestionViewModel.self) { container in
        WordsSuggestionViewModel(suggestions: container.resolve(SuggestionService.self)!,
                                 history: container.resolve(AnyStorageRepository<Suggestion>.self)!)
    }
    .inObjectScope(.container)
    
    container.register(WordsViewModel.self) { container in
        WordsViewModel(words: container.resolve(WordsService.self)!,
                       player: container.resolve(PlayerManager.self)!,
                       bookmarks: container.resolve(AnyStorageRepository<FormattedWord>.self)!)
    }
    .inObjectScope(.container)
    
    container.register(SettingsViewModel.self) { container in
        SettingsViewModel(lexinParameters: container.resolve(ParametersStorage.self)!)
    }
    .inObjectScope(.container)
    
    container.register(SettingsLanguageViewModel.self) { container in
        SettingsLanguageViewModel(settings: container.resolve(SettingsLanguageService.self)!)
    }
    .inObjectScope(.container)
    
    container.register(BookmarksViewModel.self) { container in
        BookmarksViewModel(bookmarks: container.resolve(AnyStorageRepository<FormattedWord>.self)!,
                           player: container.resolve(PlayerManager.self)!,
                           spotlight: container.resolve(ExternalCacheService.self)!)
    }
    .inObjectScope(.container)
}

func configureView(_ container: Container) {
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
    container.storyboardInitCompleted(BookmarksTableViewController.self) { container, view in
        view.model = container.resolve(BookmarksViewModel.self)
    }
    container.storyboardInitCompleted(AboutViewController.self) { container, view in
        view.markdown = container.resolve(Markdown.self)
    }
}
