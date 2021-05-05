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
    configureUseCase(container)
    configureViewModel(container)
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
    
    // Dictionary Repository
    container.register(AnyDictionaryRepository<SuggestionResult>.self) { _ in
        AnyDictionaryRepository(wrapped: SuggestionDictionaryRepository(provider: container.resolve(LexinApiProvider.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyDictionaryRepository<FoundWordResult>.self) { _ in
        AnyDictionaryRepository(wrapped: WordsDictionaryRepository(provider: container.resolve(LexinApiProvider.self)!,
                                                                   mapper: container.resolve(LexinWordMapper.self)!))
    }
    .inObjectScope(.container)
    
    // Settings Repository
    container.register(SettingsRepository.self) { _ in
        DefaultSettingsRepository(storage: container.resolve(Storage.self)!)
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
    .inObjectScope(.container)

    // Lexin Word Mapper
    container.register(LexinWordMapper.self) { _ in
        LexinWordMapper(formatter: container.resolve(LexinServiceFormatter.self)!,
                     bookmarks: container.resolve(AnyStorageRepository<FormattedWord>.self)!)
    }
    .inObjectScope(.container)
    
    // About Text Repository
    container.register(AboutTextRepository.self) { _ in
        DefaultAboutTextRepository(markdown: container.resolve(Markdown.self)!)
    }
    .inObjectScope(.container)
}

func configureUseCase(_ container: Container) {
    // About
    container.register(GetTextAboutUseCase.self) { container in
        GetTextAboutUseCase(repository: container.resolve(AboutTextRepository.self)!)
    }
    .inObjectScope(.container)

    // PlaySound
    container.register(PlaySoundUseCase.self) { container in
        PlaySoundUseCase(player: container.resolve(PlayerManager.self)!)
    }
    .inObjectScope(.container)

    // Settings
    container.register(GetLanguageSettingsUseCase.self) { container in
        GetLanguageSettingsUseCase(repository: container.resolve(SettingsRepository.self)!)
    }
    .inObjectScope(.container)
    container.register(GetLanguageListSettingsUseCase.self) { container in
        GetLanguageListSettingsUseCase(repository: container.resolve(SettingsRepository.self)!)
    }
    .inObjectScope(.container)
    container.register(UpdateLanguageSettingsUseCase.self) { container in
        UpdateLanguageSettingsUseCase(repository: container.resolve(SettingsRepository.self)!)
    }
    .inObjectScope(.container)

    // Words
    container.register(SearchWordUseCase.self) { container in
        SearchWordUseCase(words: container.resolve(AnyDictionaryRepository<FoundWordResult>.self)!,
                          settings: container.resolve(SettingsRepository.self)!,
                          bookmarks: container.resolve(AnyStorageRepository<FormattedWord>.self)!)
    }
    .inObjectScope(.container)

    // Suggestions
    container.register(AddSuggestionUseCase.self) { container in
        AddSuggestionUseCase(suggestions: container.resolve(AnyDictionaryRepository<SuggestionResult>.self)!,
                             settings: container.resolve(SettingsRepository.self)!,
                             history: container.resolve(AnyStorageRepository<Suggestion>.self)!)
    }
    .inObjectScope(.container)
    container.register(GetSuggestionUseCase.self) { container in
        GetSuggestionUseCase(suggestions: container.resolve(AnyDictionaryRepository<SuggestionResult>.self)!,
                             settings: container.resolve(SettingsRepository.self)!,
                             history: container.resolve(AnyStorageRepository<Suggestion>.self)!)
    }
    .inObjectScope(.container)
    container.register(RemoveSuggestionUseCase.self) { container in
        RemoveSuggestionUseCase(history: container.resolve(AnyStorageRepository<Suggestion>.self)!)
    }
    .inObjectScope(.container)

    // Bookmarks
    container.register(SearchBookmarkUseCase.self) { container in
        SearchBookmarkUseCase(bookmarks: container.resolve(AnyStorageRepository<FormattedWord>.self)!)
    }
    .inObjectScope(.container)
    container.register(RestoreBookmarkUseCase.self) { container in
        RestoreBookmarkUseCase(cache: container.resolve(ExternalCacheService.self)!)
    }
    .inObjectScope(.container)
    container.register(RemoveBookmarkByIndexUseCase.self) { container in
        RemoveBookmarkByIndexUseCase(bookmarks: container.resolve(AnyStorageRepository<FormattedWord>.self)!)
    }
    .inObjectScope(.container)
    container.register(RemoveBookmarkUseCase.self) { container in
        RemoveBookmarkUseCase(bookmarks: container.resolve(AnyStorageRepository<FormattedWord>.self)!)
    }
    .inObjectScope(.container)
    container.register(ChangedBookmarkUseCase.self) { container in
        ChangedBookmarkUseCase(bookmarks: container.resolve(AnyStorageRepository<FormattedWord>.self)!, cache: container.resolve(ExternalCacheService.self)!)
    }
    .inObjectScope(.container)
    container.register(AddBookmarkUseCase.self) { container in
        AddBookmarkUseCase(bookmarks: container.resolve(AnyStorageRepository<FormattedWord>.self)!)
    }
    .inObjectScope(.container)
}

func configureViewModel(_ container: Container) {
    container.register(WordsSuggestionViewModel.self) { container in
        WordsSuggestionViewModel(getSuggestion: container.resolve(GetSuggestionUseCase.self)!, addSuggestion: container.resolve(AddSuggestionUseCase.self)!, removeSuggestion: container.resolve(RemoveSuggestionUseCase.self)!)
    }
    .inObjectScope(.container)
    
    container.register(WordsViewModel.self) { container in
        WordsViewModel(searchWord: container.resolve(SearchWordUseCase.self)!, addBookmark: container.resolve(AddBookmarkUseCase.self)!, playSound: container.resolve(PlaySoundUseCase.self)!, removeBookmark: container.resolve(RemoveBookmarkUseCase.self)!)
    }
    .inObjectScope(.container)
    
    container.register(SettingsViewModel.self) { container in
        SettingsViewModel(getLanguage: container.resolve(GetLanguageSettingsUseCase.self)!)
    }
    .inObjectScope(.container)
    
    container.register(SettingsLanguageViewModel.self) { container in
        SettingsLanguageViewModel(getLanguageList: container.resolve(GetLanguageListSettingsUseCase.self)!, updateLanguage: container.resolve(UpdateLanguageSettingsUseCase.self)!)
    }
    .inObjectScope(.container)
    
    container.register(BookmarksViewModel.self) { container in
        BookmarksViewModel(searchBookmark: container.resolve(SearchBookmarkUseCase.self)!, restoreBookmark: container.resolve(RestoreBookmarkUseCase.self)!, removeBookmark: container.resolve(RemoveBookmarkByIndexUseCase.self)!, changedBookmark: container.resolve(ChangedBookmarkUseCase.self)!, playSound: container.resolve(PlaySoundUseCase.self)!)
    }
    .inObjectScope(.container)
    
    container.register(AboutViewModel.self) { container in
        AboutViewModel(getText: container.resolve(GetTextAboutUseCase.self)!)
    }
    .inObjectScope(.container)
}

func configureView(_ container: Container) {
    container.registerForStoryboard(WordsSuggestionTableViewController.self,
                                    withIdentifier: "WordsSuggestionTableViewController") { container, view  in
        view.viewModel = container.resolve(WordsSuggestionViewModel.self)!
    }
    container.storyboardInitCompleted(WordsTableViewController.self) { container, view in
        view.viewModel = container.resolve(WordsViewModel.self)!
        view.searchResultsController = container.resolve(WordsSuggestionTableViewController.self)!
    }
    container.storyboardInitCompleted(SettingsTableViewController.self) { container, view in
        view.viewModel = container.resolve(SettingsViewModel.self)!
    }
    container.storyboardInitCompleted(SettingsLanguageTableViewController.self) { container, view in
        view.viewModel = container.resolve(SettingsLanguageViewModel.self)!
    }
    container.storyboardInitCompleted(BookmarksTableViewController.self) { container, view in
        view.viewModel = container.resolve(BookmarksViewModel.self)!
    }
    container.storyboardInitCompleted(AboutViewController.self) { container, view in
        view.viewModel = container.resolve(AboutViewModel.self)!
    }
}
