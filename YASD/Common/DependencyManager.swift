//
//  DependencyManager.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 29/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import UIKit

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
    container.register(Network.self) { _ in DefaultNetwork() }
        .inObjectScope(.container)
    container.register(HtmlParser.self) { _ in DefaultHtmlParser() }
        .inObjectScope(.container)
    container.register(Markdown.self) { _ in DefaultMarkdown() }
        .inObjectScope(.container)
    container.register(Storage.self) { _ in DefaultStorage() }
        .inObjectScope(.container)
    container.register(Player.self) { _ in DefaultPlayer() }
        .inObjectScope(.container)
    container.register(DataCache.self) { _, name in DefaultDataCache(name: name) }
        .inObjectScope(.container)
    container.register(ExternalCacheService.self) { _ in Spotlight() }
        .inObjectScope(.container)
}

func configureApi(_ container: Container) {
    // Api
    container.register(LexinApi.self, name: "LexinApi") { _ in
        LexinApi(network: container.resolve(NetworkService.self)!,
                 parserWords: container.resolve(LexinParserWordsDefault.self)!,
                 parserSuggestions: container.resolve(LexinParserSuggestionDefault.self)!)
    }
    container.register(LexinApi.self, name: "LexinApiSwedish") { _ in
        LexinApi(network: container.resolve(NetworkService.self)!,
                 parserWords: container.resolve(LexinParserWordsSwedish.self)!,
                 parserSuggestions: container.resolve(LexinParserSuggestionDefault.self)!)
    }
    container.register(LexinApi.self, name: "LexinApiFolkets") { _ in
        LexinApi(network: container.resolve(NetworkService.self)!,
                 parserWords: container.resolve(LexinParserWordsFolkets.self)!,
                 parserSuggestions: container.resolve(LexinParserSuggestionFolkets.self)!)
    }
    // Provider
    container.register(LexinApiProvider.self) { _ in
        LexinApiProvider(defaultApi: container.resolve(LexinApi.self, name: "LexinApi")!,
                         folketsApi: container.resolve(LexinApi.self, name: "LexinApiFolkets")!,
                         swedishApi: container.resolve(LexinApi.self, name: "LexinApiSwedish")!)
    }
    .inObjectScope(.container)
}

// swiftlint:disable function_body_length
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
        DefaultCacheService(cache: container.resolve(DataCache.self, argument: "CacheService")!)
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
        AnyDictionaryRepository(wrapped:
            SuggestionDictionaryRepository(provider: container.resolve(LexinApiProvider.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyDictionaryRepository<FoundWordResult>.self) { _ in
        AnyDictionaryRepository(wrapped:
            WordsDictionaryRepository(provider: container.resolve(LexinApiProvider.self)!,
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
        AnyStorageRepository(wrapped:
            DefaultStorageRepository<Suggestion>(id: "history",
                                                 storage: container.resolve(Storage.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyStorageRepository<FormattedWord>.self) { _ in
        AnyStorageRepository(wrapped:
            DefaultStorageRepository<FormattedWord>(id: "bookmarks",
                                                    storage: container.resolve(Storage.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyStorageRepository<Suggestion>.self) { _ in
        AnyStorageRepository(wrapped:
            DefaultStorageRepository<Suggestion>(id: "history",
                                                 storage: container.resolve(Storage.self)!))
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
    container.register(AnyUseCase<Void, AboutTextRepositoryResult>.self,
                       name: "GetTextAboutUseCase") { container in
        AnyUseCase(wrapped: GetTextAboutUseCase(repository: container.resolve(AboutTextRepository.self)!))
    }
    .inObjectScope(.container)

    // PlaySound
    container.register(AnyUseCase<String, PlayerManagerResult>.self, name: "PlaySoundUseCase") { container in
        AnyUseCase(wrapped: PlaySoundUseCase(player: container.resolve(PlayerManager.self)!))
    }
    .inObjectScope(.container)

    // Settings
    container.register(AnyUseCase<Void, SettingsRepositoryLanguageResult>.self,
                       name: "GetLanguageSettingsUseCase") { container in
        AnyUseCase(wrapped: GetLanguageSettingsUseCase(repository: container.resolve(SettingsRepository.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyUseCase<String, SettingsRepositoryItemResult>.self,
                       name: "GetLanguageListSettingsUseCase") { container in
        AnyUseCase(wrapped: GetLanguageListSettingsUseCase(repository: container.resolve(SettingsRepository.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyUseCase<String, SettingsRepositoryResult>.self,
                       name: "UpdateLanguageSettingsUseCase") { container in
        AnyUseCase(wrapped: UpdateLanguageSettingsUseCase(repository: container.resolve(SettingsRepository.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyUseCase<Void, String>.self,
                       name: "GetHistorySizeUseCase") { container in
        AnyUseCase(wrapped: GetHistorySizeUseCase(history: container.resolve(AnyStorageRepository.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyUseCase<Void, String>.self,
                       name: "GetCacheSizeUseCase") { container in
        AnyUseCase(wrapped: GetCacheSizeUseCase(cache: container.resolve(CacheService.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyUseCase<Void, StorageServiceResult>.self,
                       name: "ClearHistoryUseCase") { container in
        AnyUseCase(wrapped: ClearHistoryUseCase(history: container.resolve(AnyStorageRepository.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyUseCase<Void, CacheServiceBoolResult>.self,
                       name: "ClearCacheUseCase") { container in
        AnyUseCase(wrapped: ClearCacheUseCase(cache: container.resolve(CacheService.self)!))
    }
    .inObjectScope(.container)

    // Words
    container.register(AnyUseCase<SearchWordUseCase.Input, FoundWordResult>.self,
                       name: "SearchWordUseCase") { container in
        AnyUseCase(wrapped: SearchWordUseCase(words: container.resolve(AnyDictionaryRepository.self)!,
                                              settings: container.resolve(SettingsRepository.self)!,
                                              bookmarks: container.resolve(AnyStorageRepository.self)!))
    }
    .inObjectScope(.container)

    // Suggestions
    container.register(AnyUseCase<String, SuggestionItemResult>.self,
                       name: "AddSuggestionUseCase") { container in
        AnyUseCase(wrapped: AddSuggestionUseCase(suggestions:
            container.resolve(AnyDictionaryRepository.self)!,
            settings: container.resolve(SettingsRepository.self)!,
            history: container.resolve(AnyStorageRepository.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyUseCase<String, SuggestionItemResult>.self,
                       name: "GetSuggestionUseCase") { container in
        AnyUseCase(wrapped: GetSuggestionUseCase(suggestions:
            container.resolve(AnyDictionaryRepository.self)!,
            settings: container.resolve(SettingsRepository.self)!,
            history: container.resolve(AnyStorageRepository.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyUseCase<String, StorageServiceResult>.self,
                       name: "RemoveSuggestionUseCase") { container in
        AnyUseCase(wrapped: RemoveSuggestionUseCase(history:
            container.resolve(AnyStorageRepository.self)!))
    }
    .inObjectScope(.container)

    // Bookmarks
    container.register(AnyUseCase<String, Bookmarks>.self,
                       name: "SearchBookmarkUseCase") { container in
        AnyUseCase(wrapped: SearchBookmarkUseCase(bookmarks:
            container.resolve(AnyStorageRepository.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyUseCase<String, String>.self,
                       name: "RestoreBookmarkUseCase") { container in
        AnyUseCase(wrapped: RestoreBookmarkUseCase(cache:
            container.resolve(ExternalCacheService.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyUseCase<Int, StorageServiceResult>.self,
                       name: "RemoveBookmarkByIndexUseCase") { container in
        AnyUseCase(wrapped:
            RemoveBookmarkByIndexUseCase(bookmarks:
                container.resolve(AnyStorageRepository.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyUseCase<FormattedWord, StorageServiceResult>.self,
                       name: "RemoveBookmarkUseCase") { container in
        AnyUseCase(wrapped:
            RemoveBookmarkUseCase(bookmarks:
                container.resolve(AnyStorageRepository.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyUseCase<Void, Bookmarks>.self, name: "ChangedBookmarkUseCase") { container in
        AnyUseCase(wrapped: ChangedBookmarkUseCase(bookmarks:
            container.resolve(AnyStorageRepository.self)!,
            cache: container.resolve(ExternalCacheService.self)!))
    }
    .inObjectScope(.container)
    container.register(AnyUseCase<FormattedWord, StorageServiceResult>.self, name: "AddBookmarkUseCase") { container in
        AnyUseCase(wrapped: AddBookmarkUseCase(bookmarks: container.resolve(AnyStorageRepository.self)!))
    }
    .inObjectScope(.container)
}

func configureViewModel(_ container: Container) {
    container.register(WordsSuggestionViewModel.self) { container in
        WordsSuggestionViewModel(getSuggestion: container.resolve(AnyUseCase.self, name: "GetSuggestionUseCase")!,
                                 addSuggestion: container.resolve(AnyUseCase.self, name: "AddSuggestionUseCase")!,
                                 removeSuggestion: container.resolve(AnyUseCase.self, name: "RemoveSuggestionUseCase")!)
    }
    .inObjectScope(.container)

    container.register(WordsViewModel.self) { container in
        WordsViewModel(searchWord: container.resolve(AnyUseCase.self, name: "SearchWordUseCase")!,
                       addBookmark: container.resolve(AnyUseCase.self, name: "AddBookmarkUseCase")!,
                       playSound: container.resolve(AnyUseCase.self, name: "PlaySoundUseCase")!,
                       removeBookmark: container.resolve(AnyUseCase.self, name: "RemoveBookmarkUseCase")!)
    }
    .inObjectScope(.container)

    container.register(SettingsViewModel.self) { container in
        SettingsViewModel(getLanguage: container.resolve(AnyUseCase.self, name: "GetLanguageSettingsUseCase")!,
                          getHistorySize: container.resolve(AnyUseCase.self, name: "GetHistorySizeUseCase")!,
                          getCacheSize: container.resolve(AnyUseCase.self, name: "GetCacheSizeUseCase")!,
                          clearHistory: container.resolve(AnyUseCase.self, name: "ClearHistoryUseCase")!,
                          clearCache: container.resolve(AnyUseCase.self, name: "ClearCacheUseCase")!)
    }
    .inObjectScope(.container)

    container.register(SettingsLanguageViewModel.self) { container in
        SettingsLanguageViewModel(getLanguageList: container.resolve(AnyUseCase.self,
                                                                     name: "GetLanguageListSettingsUseCase")!,
                                  updateLanguage: container.resolve(AnyUseCase.self,
                                                                    name: "UpdateLanguageSettingsUseCase")!)
    }
    .inObjectScope(.container)

    container.register(BookmarksViewModel.self) { container in
        BookmarksViewModel(searchBookmark: container.resolve(AnyUseCase.self, name: "SearchBookmarkUseCase")!,
                           restoreBookmark: container.resolve(AnyUseCase.self, name: "RestoreBookmarkUseCase")!,
                           removeBookmark: container.resolve(AnyUseCase.self, name: "RemoveBookmarkByIndexUseCase")!,
                           changedBookmark: container.resolve(AnyUseCase.self, name: "ChangedBookmarkUseCase")!,
                           playSound: container.resolve(AnyUseCase.self, name: "PlaySoundUseCase")!)
    }
    .inObjectScope(.container)

    container.register(AboutViewModel.self) { container in
        AboutViewModel(getText: container.resolve(AnyUseCase.self, name: "GetTextAboutUseCase")!)
    }
    .inObjectScope(.container)
}

func configureView(_ container: Container) {
    container.registerForStoryboard(WordsSuggestionTableViewController.self,
                                    withIdentifier: "WordsSuggestionTableViewController") { container, view in
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
