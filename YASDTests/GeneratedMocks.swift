// MARK: - Mocks generated from file: YASD/Model/FormattedWord.swift at 2020-06-02 16:25:56 +0000

//
//  FormattedWord.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation

// MARK: - Mocks generated from file: YASD/Model/Lexin/LexinWord.swift at 2020-06-02 16:25:56 +0000

//
//  LexinWord.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation

// MARK: - Mocks generated from file: YASD/Model/ParametersStorage.swift at 2020-06-02 16:25:56 +0000

//
//  ParametersStorage.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import RxSwift


 class MockParametersStorage: ParametersStorage, Cuckoo.ClassMock {
    
     typealias MocksType = ParametersStorage
    
     typealias Stubbing = __StubbingProxy_ParametersStorage
     typealias Verification = __VerificationProxy_ParametersStorage

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: ParametersStorage?

     func enableDefaultImplementation(_ stub: ParametersStorage) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getLanguageString() -> String {
        
    return cuckoo_manager.call("getLanguageString() -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getLanguageString()
                ,
            defaultCall: __defaultImplStub!.getLanguageString())
        
    }
    
    
    
     override func getLanguageCode() -> String {
        
    return cuckoo_manager.call("getLanguageCode() -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getLanguageCode()
                ,
            defaultCall: __defaultImplStub!.getLanguageCode())
        
    }
    
    
    
     override func setLanguage(_ language: Language)  {
        
    return cuckoo_manager.call("setLanguage(_: Language)",
            parameters: (language),
            escapingParameters: (language),
            superclassCall:
                
                super.setLanguage(language)
                ,
            defaultCall: __defaultImplStub!.setLanguage(language))
        
    }
    
    
    
     override func getLanguage() -> Language {
        
    return cuckoo_manager.call("getLanguage() -> Language",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getLanguage()
                ,
            defaultCall: __defaultImplStub!.getLanguage())
        
    }
    

	 struct __StubbingProxy_ParametersStorage: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getLanguageString() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockParametersStorage.self, method: "getLanguageString() -> String", parameterMatchers: matchers))
	    }
	    
	    func getLanguageCode() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockParametersStorage.self, method: "getLanguageCode() -> String", parameterMatchers: matchers))
	    }
	    
	    func setLanguage<M1: Cuckoo.Matchable>(_ language: M1) -> Cuckoo.ClassStubNoReturnFunction<(Language)> where M1.MatchedType == Language {
	        let matchers: [Cuckoo.ParameterMatcher<(Language)>] = [wrap(matchable: language) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockParametersStorage.self, method: "setLanguage(_: Language)", parameterMatchers: matchers))
	    }
	    
	    func getLanguage() -> Cuckoo.ClassStubFunction<(), Language> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockParametersStorage.self, method: "getLanguage() -> Language", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ParametersStorage: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getLanguageString() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getLanguageString() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getLanguageCode() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getLanguageCode() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setLanguage<M1: Cuckoo.Matchable>(_ language: M1) -> Cuckoo.__DoNotUse<(Language), Void> where M1.MatchedType == Language {
	        let matchers: [Cuckoo.ParameterMatcher<(Language)>] = [wrap(matchable: language) { $0 }]
	        return cuckoo_manager.verify("setLanguage(_: Language)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getLanguage() -> Cuckoo.__DoNotUse<(), Language> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getLanguage() -> Language", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ParametersStorageStub: ParametersStorage {
    

    

    
     override func getLanguageString() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     override func getLanguageCode() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     override func setLanguage(_ language: Language)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getLanguage() -> Language  {
        return DefaultValueRegistry.defaultValue(for: (Language).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Model/Suggestion.swift at 2020-06-02 16:25:56 +0000

//
//  Suggestion.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation

// MARK: - Mocks generated from file: YASD/Platform/DataCache.swift at 2020-06-02 16:25:56 +0000

//
//  DataCache.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Cache
import Foundation
import RxSwift


 class MockDataCache: DataCache, Cuckoo.ClassMock {
    
     typealias MocksType = DataCache
    
     typealias Stubbing = __StubbingProxy_DataCache
     typealias Verification = __VerificationProxy_DataCache

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: DataCache?

     func enableDefaultImplementation(_ stub: DataCache) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func save(_ data: Data, forKey key: String) -> Observable<Data> {
        
    return cuckoo_manager.call("save(_: Data, forKey: String) -> Observable<Data>",
            parameters: (data, key),
            escapingParameters: (data, key),
            superclassCall:
                
                super.save(data, forKey: key)
                ,
            defaultCall: __defaultImplStub!.save(data, forKey: key))
        
    }
    
    
    
     override func load(_ key: String) -> Observable<Data?> {
        
    return cuckoo_manager.call("load(_: String) -> Observable<Data?>",
            parameters: (key),
            escapingParameters: (key),
            superclassCall:
                
                super.load(key)
                ,
            defaultCall: __defaultImplStub!.load(key))
        
    }
    

	 struct __StubbingProxy_DataCache: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ data: M1, forKey key: M2) -> Cuckoo.ClassStubFunction<(Data, String), Observable<Data>> where M1.MatchedType == Data, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Data, String)>] = [wrap(matchable: data) { $0.0 }, wrap(matchable: key) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDataCache.self, method: "save(_: Data, forKey: String) -> Observable<Data>", parameterMatchers: matchers))
	    }
	    
	    func load<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.ClassStubFunction<(String), Observable<Data?>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDataCache.self, method: "load(_: String) -> Observable<Data?>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DataCache: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ data: M1, forKey key: M2) -> Cuckoo.__DoNotUse<(Data, String), Observable<Data>> where M1.MatchedType == Data, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Data, String)>] = [wrap(matchable: data) { $0.0 }, wrap(matchable: key) { $0.1 }]
	        return cuckoo_manager.verify("save(_: Data, forKey: String) -> Observable<Data>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func load<M1: Cuckoo.Matchable>(_ key: M1) -> Cuckoo.__DoNotUse<(String), Observable<Data?>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
	        return cuckoo_manager.verify("load(_: String) -> Observable<Data?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DataCacheStub: DataCache {
    

    

    
     override func save(_ data: Data, forKey key: String) -> Observable<Data>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Data>).self)
    }
    
     override func load(_ key: String) -> Observable<Data?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Data?>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Platform/HtmlParser.swift at 2020-06-02 16:25:56 +0000


//
//  File.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15/06/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
import SwiftSoup


 class MockHtmlParserElement: HtmlParserElement, Cuckoo.ProtocolMock {
    
     typealias MocksType = HtmlParserElement
    
     typealias Stubbing = __StubbingProxy_HtmlParserElement
     typealias Verification = __VerificationProxy_HtmlParserElement

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: HtmlParserElement?

     func enableDefaultImplementation(_ stub: HtmlParserElement) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func attribute(_ id: String) throws -> String {
        
    return try cuckoo_manager.callThrows("attribute(_: String) throws -> String",
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.attribute(id))
        
    }
    
    
    
     func text() throws -> String {
        
    return try cuckoo_manager.callThrows("text() throws -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.text())
        
    }
    
    
    
     func selectText(_ query: String) throws -> String {
        
    return try cuckoo_manager.callThrows("selectText(_: String) throws -> String",
            parameters: (query),
            escapingParameters: (query),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.selectText(query))
        
    }
    
    
    
     func selectTexts(_ query: String) throws -> [String] {
        
    return try cuckoo_manager.callThrows("selectTexts(_: String) throws -> [String]",
            parameters: (query),
            escapingParameters: (query),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.selectTexts(query))
        
    }
    
    
    
     func selectElements(_ query: String) throws -> [HtmlParserElement] {
        
    return try cuckoo_manager.callThrows("selectElements(_: String) throws -> [HtmlParserElement]",
            parameters: (query),
            escapingParameters: (query),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.selectElements(query))
        
    }
    

	 struct __StubbingProxy_HtmlParserElement: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func attribute<M1: Cuckoo.Matchable>(_ id: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), String> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHtmlParserElement.self, method: "attribute(_: String) throws -> String", parameterMatchers: matchers))
	    }
	    
	    func text() -> Cuckoo.ProtocolStubThrowingFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockHtmlParserElement.self, method: "text() throws -> String", parameterMatchers: matchers))
	    }
	    
	    func selectText<M1: Cuckoo.Matchable>(_ query: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), String> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHtmlParserElement.self, method: "selectText(_: String) throws -> String", parameterMatchers: matchers))
	    }
	    
	    func selectTexts<M1: Cuckoo.Matchable>(_ query: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), [String]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHtmlParserElement.self, method: "selectTexts(_: String) throws -> [String]", parameterMatchers: matchers))
	    }
	    
	    func selectElements<M1: Cuckoo.Matchable>(_ query: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), [HtmlParserElement]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHtmlParserElement.self, method: "selectElements(_: String) throws -> [HtmlParserElement]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_HtmlParserElement: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func attribute<M1: Cuckoo.Matchable>(_ id: M1) -> Cuckoo.__DoNotUse<(String), String> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("attribute(_: String) throws -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func text() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("text() throws -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func selectText<M1: Cuckoo.Matchable>(_ query: M1) -> Cuckoo.__DoNotUse<(String), String> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return cuckoo_manager.verify("selectText(_: String) throws -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func selectTexts<M1: Cuckoo.Matchable>(_ query: M1) -> Cuckoo.__DoNotUse<(String), [String]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return cuckoo_manager.verify("selectTexts(_: String) throws -> [String]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func selectElements<M1: Cuckoo.Matchable>(_ query: M1) -> Cuckoo.__DoNotUse<(String), [HtmlParserElement]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: query) { $0 }]
	        return cuckoo_manager.verify("selectElements(_: String) throws -> [HtmlParserElement]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class HtmlParserElementStub: HtmlParserElement {
    

    

    
     func attribute(_ id: String) throws -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     func text() throws -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     func selectText(_ query: String) throws -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     func selectTexts(_ query: String) throws -> [String]  {
        return DefaultValueRegistry.defaultValue(for: ([String]).self)
    }
    
     func selectElements(_ query: String) throws -> [HtmlParserElement]  {
        return DefaultValueRegistry.defaultValue(for: ([HtmlParserElement]).self)
    }
    
}



 class MockHtmlParser: HtmlParser, Cuckoo.ClassMock {
    
     typealias MocksType = HtmlParser
    
     typealias Stubbing = __StubbingProxy_HtmlParser
     typealias Verification = __VerificationProxy_HtmlParser

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: HtmlParser?

     func enableDefaultImplementation(_ stub: HtmlParser) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func parse(html: String, query: String) throws -> [HtmlParserElement] {
        
    return try cuckoo_manager.callThrows("parse(html: String, query: String) throws -> [HtmlParserElement]",
            parameters: (html, query),
            escapingParameters: (html, query),
            superclassCall:
                
                super.parse(html: html, query: query)
                ,
            defaultCall: __defaultImplStub!.parse(html: html, query: query))
        
    }
    

	 struct __StubbingProxy_HtmlParser: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func parse<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(html: M1, query: M2) -> Cuckoo.ClassStubThrowingFunction<(String, String), [HtmlParserElement]> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: html) { $0.0 }, wrap(matchable: query) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockHtmlParser.self, method: "parse(html: String, query: String) throws -> [HtmlParserElement]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_HtmlParser: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(html: M1, query: M2) -> Cuckoo.__DoNotUse<(String, String), [HtmlParserElement]> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: html) { $0.0 }, wrap(matchable: query) { $0.1 }]
	        return cuckoo_manager.verify("parse(html: String, query: String) throws -> [HtmlParserElement]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class HtmlParserStub: HtmlParser {
    

    

    
     override func parse(html: String, query: String) throws -> [HtmlParserElement]  {
        return DefaultValueRegistry.defaultValue(for: ([HtmlParserElement]).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Platform/Markdown.swift at 2020-06-02 16:25:56 +0000

//
//  MarkdownParser.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15/06/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import MarkdownKit
import UIKit


 class MockMarkdown: Markdown, Cuckoo.ClassMock {
    
     typealias MocksType = Markdown
    
     typealias Stubbing = __StubbingProxy_Markdown
     typealias Verification = __VerificationProxy_Markdown

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: Markdown?

     func enableDefaultImplementation(_ stub: Markdown) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func parse(data: String) -> NSAttributedString {
        
    return cuckoo_manager.call("parse(data: String) -> NSAttributedString",
            parameters: (data),
            escapingParameters: (data),
            superclassCall:
                
                super.parse(data: data)
                ,
            defaultCall: __defaultImplStub!.parse(data: data))
        
    }
    

	 struct __StubbingProxy_Markdown: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func parse<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.ClassStubFunction<(String), NSAttributedString> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: data) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMarkdown.self, method: "parse(data: String) -> NSAttributedString", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Markdown: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.__DoNotUse<(String), NSAttributedString> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: data) { $0 }]
	        return cuckoo_manager.verify("parse(data: String) -> NSAttributedString", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class MarkdownStub: Markdown {
    

    

    
     override func parse(data: String) -> NSAttributedString  {
        return DefaultValueRegistry.defaultValue(for: (NSAttributedString).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Platform/Network.swift at 2020-06-02 16:25:56 +0000

//
//  Network.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 31/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
import RxSwift


 class MockNetwork: Network, Cuckoo.ClassMock {
    
     typealias MocksType = Network
    
     typealias Stubbing = __StubbingProxy_Network
     typealias Verification = __VerificationProxy_Network

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: Network?

     func enableDefaultImplementation(_ stub: Network) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func postRequest(with parameters: PostParameters) -> Observable<NetworkResult> {
        
    return cuckoo_manager.call("postRequest(with: PostParameters) -> Observable<NetworkResult>",
            parameters: (parameters),
            escapingParameters: (parameters),
            superclassCall:
                
                super.postRequest(with: parameters)
                ,
            defaultCall: __defaultImplStub!.postRequest(with: parameters))
        
    }
    
    
    
     override func getRequest(with url: String) -> Observable<NetworkResult> {
        
    return cuckoo_manager.call("getRequest(with: String) -> Observable<NetworkResult>",
            parameters: (url),
            escapingParameters: (url),
            superclassCall:
                
                super.getRequest(with: url)
                ,
            defaultCall: __defaultImplStub!.getRequest(with: url))
        
    }
    

	 struct __StubbingProxy_Network: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func postRequest<M1: Cuckoo.Matchable>(with parameters: M1) -> Cuckoo.ClassStubFunction<(PostParameters), Observable<NetworkResult>> where M1.MatchedType == PostParameters {
	        let matchers: [Cuckoo.ParameterMatcher<(PostParameters)>] = [wrap(matchable: parameters) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetwork.self, method: "postRequest(with: PostParameters) -> Observable<NetworkResult>", parameterMatchers: matchers))
	    }
	    
	    func getRequest<M1: Cuckoo.Matchable>(with url: M1) -> Cuckoo.ClassStubFunction<(String), Observable<NetworkResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetwork.self, method: "getRequest(with: String) -> Observable<NetworkResult>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Network: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func postRequest<M1: Cuckoo.Matchable>(with parameters: M1) -> Cuckoo.__DoNotUse<(PostParameters), Observable<NetworkResult>> where M1.MatchedType == PostParameters {
	        let matchers: [Cuckoo.ParameterMatcher<(PostParameters)>] = [wrap(matchable: parameters) { $0 }]
	        return cuckoo_manager.verify("postRequest(with: PostParameters) -> Observable<NetworkResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRequest<M1: Cuckoo.Matchable>(with url: M1) -> Cuckoo.__DoNotUse<(String), Observable<NetworkResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return cuckoo_manager.verify("getRequest(with: String) -> Observable<NetworkResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class NetworkStub: Network {
    

    

    
     override func postRequest(with parameters: PostParameters) -> Observable<NetworkResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<NetworkResult>).self)
    }
    
     override func getRequest(with url: String) -> Observable<NetworkResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<NetworkResult>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Platform/Player.swift at 2020-06-02 16:25:56 +0000

//
//  Player.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 06/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import AVFoundation
import Foundation


 class MockPlayer: Player, Cuckoo.ClassMock {
    
     typealias MocksType = Player
    
     typealias Stubbing = __StubbingProxy_Player
     typealias Verification = __VerificationProxy_Player

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: Player?

     func enableDefaultImplementation(_ stub: Player) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var player: AVAudioPlayer? {
        get {
            return cuckoo_manager.getter("player",
                superclassCall:
                    
                    super.player
                    ,
                defaultCall: __defaultImplStub!.player)
        }
        
        set {
            cuckoo_manager.setter("player",
                value: newValue,
                superclassCall:
                    
                    super.player = newValue
                    ,
                defaultCall: __defaultImplStub!.player = newValue)
        }
        
    }
    

    

    
    
    
     override func play(with data: Data) throws {
        
    return try cuckoo_manager.callThrows("play(with: Data) throws",
            parameters: (data),
            escapingParameters: (data),
            superclassCall:
                
                super.play(with: data)
                ,
            defaultCall: __defaultImplStub!.play(with: data))
        
    }
    

	 struct __StubbingProxy_Player: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var player: Cuckoo.ClassToBeStubbedOptionalProperty<MockPlayer, AVAudioPlayer> {
	        return .init(manager: cuckoo_manager, name: "player")
	    }
	    
	    
	    func play<M1: Cuckoo.Matchable>(with data: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<(Data)> where M1.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(Data)>] = [wrap(matchable: data) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPlayer.self, method: "play(with: Data) throws", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Player: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var player: Cuckoo.VerifyOptionalProperty<AVAudioPlayer> {
	        return .init(manager: cuckoo_manager, name: "player", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func play<M1: Cuckoo.Matchable>(with data: M1) -> Cuckoo.__DoNotUse<(Data), Void> where M1.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(Data)>] = [wrap(matchable: data) { $0 }]
	        return cuckoo_manager.verify("play(with: Data) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class PlayerStub: Player {
    
    
     override var player: AVAudioPlayer? {
        get {
            return DefaultValueRegistry.defaultValue(for: (AVAudioPlayer?).self)
        }
        
        set { }
        
    }
    

    

    
     override func play(with data: Data) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Platform/Spotlight.swift at 2020-06-02 16:25:56 +0000

//
//  Spotlight.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 09.05.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import CoreSpotlight
import Foundation
import MobileCoreServices
import RxSwift


 class MockSpotlight: Spotlight, Cuckoo.ClassMock {
    
     typealias MocksType = Spotlight
    
     typealias Stubbing = __StubbingProxy_Spotlight
     typealias Verification = __VerificationProxy_Spotlight

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: Spotlight?

     func enableDefaultImplementation(_ stub: Spotlight) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func index(data: [FormattedWord]) -> Observable<SpotlightResult> {
        
    return cuckoo_manager.call("index(data: [FormattedWord]) -> Observable<SpotlightResult>",
            parameters: (data),
            escapingParameters: (data),
            superclassCall:
                
                super.index(data: data)
                ,
            defaultCall: __defaultImplStub!.index(data: data))
        
    }
    
    
    
     override func getTitle(from id: String) -> String {
        
    return cuckoo_manager.call("getTitle(from: String) -> String",
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                super.getTitle(from: id)
                ,
            defaultCall: __defaultImplStub!.getTitle(from: id))
        
    }
    

	 struct __StubbingProxy_Spotlight: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func index<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.ClassStubFunction<([FormattedWord]), Observable<SpotlightResult>> where M1.MatchedType == [FormattedWord] {
	        let matchers: [Cuckoo.ParameterMatcher<([FormattedWord])>] = [wrap(matchable: data) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSpotlight.self, method: "index(data: [FormattedWord]) -> Observable<SpotlightResult>", parameterMatchers: matchers))
	    }
	    
	    func getTitle<M1: Cuckoo.Matchable>(from id: M1) -> Cuckoo.ClassStubFunction<(String), String> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSpotlight.self, method: "getTitle(from: String) -> String", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Spotlight: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func index<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.__DoNotUse<([FormattedWord]), Observable<SpotlightResult>> where M1.MatchedType == [FormattedWord] {
	        let matchers: [Cuckoo.ParameterMatcher<([FormattedWord])>] = [wrap(matchable: data) { $0 }]
	        return cuckoo_manager.verify("index(data: [FormattedWord]) -> Observable<SpotlightResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTitle<M1: Cuckoo.Matchable>(from id: M1) -> Cuckoo.__DoNotUse<(String), String> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getTitle(from: String) -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class SpotlightStub: Spotlight {
    

    

    
     override func index(data: [FormattedWord]) -> Observable<SpotlightResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<SpotlightResult>).self)
    }
    
     override func getTitle(from id: String) -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Platform/Storage.swift at 2020-06-02 16:25:56 +0000

//
//  Storage.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/08/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation


 class MockStorage: Storage, Cuckoo.ClassMock {
    
     typealias MocksType = Storage
    
     typealias Stubbing = __StubbingProxy_Storage
     typealias Verification = __VerificationProxy_Storage

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: Storage?

     func enableDefaultImplementation(_ stub: Storage) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func get<T: Codable>(id: String, defaultObject: T) -> T {
        
    return cuckoo_manager.call("get(id: String, defaultObject: T) -> T",
            parameters: (id, defaultObject),
            escapingParameters: (id, defaultObject),
            superclassCall:
                
                super.get(id: id, defaultObject: defaultObject)
                ,
            defaultCall: __defaultImplStub!.get(id: id, defaultObject: defaultObject))
        
    }
    
    
    
     override func save<T: Codable>(id: String, object: T) throws {
        
    return try cuckoo_manager.callThrows("save(id: String, object: T) throws",
            parameters: (id, object),
            escapingParameters: (id, object),
            superclassCall:
                
                super.save(id: id, object: object)
                ,
            defaultCall: __defaultImplStub!.save(id: id, object: object))
        
    }
    

	 struct __StubbingProxy_Storage: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func get<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, T: Codable>(id: M1, defaultObject: M2) -> Cuckoo.ClassStubFunction<(String, T), T> where M1.MatchedType == String, M2.MatchedType == T {
	        let matchers: [Cuckoo.ParameterMatcher<(String, T)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: defaultObject) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockStorage.self, method: "get(id: String, defaultObject: T) -> T", parameterMatchers: matchers))
	    }
	    
	    func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, T: Codable>(id: M1, object: M2) -> Cuckoo.ClassStubNoReturnThrowingFunction<(String, T)> where M1.MatchedType == String, M2.MatchedType == T {
	        let matchers: [Cuckoo.ParameterMatcher<(String, T)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: object) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockStorage.self, method: "save(id: String, object: T) throws", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Storage: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func get<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, T: Codable>(id: M1, defaultObject: M2) -> Cuckoo.__DoNotUse<(String, T), T> where M1.MatchedType == String, M2.MatchedType == T {
	        let matchers: [Cuckoo.ParameterMatcher<(String, T)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: defaultObject) { $0.1 }]
	        return cuckoo_manager.verify("get(id: String, defaultObject: T) -> T", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, T: Codable>(id: M1, object: M2) -> Cuckoo.__DoNotUse<(String, T), Void> where M1.MatchedType == String, M2.MatchedType == T {
	        let matchers: [Cuckoo.ParameterMatcher<(String, T)>] = [wrap(matchable: id) { $0.0 }, wrap(matchable: object) { $0.1 }]
	        return cuckoo_manager.verify("save(id: String, object: T) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class StorageStub: Storage {
    

    

    
     override func get<T: Codable>(id: String, defaultObject: T) -> T  {
        return DefaultValueRegistry.defaultValue(for: (T).self)
    }
    
     override func save<T: Codable>(id: String, object: T) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/CacheService.swift at 2020-06-02 16:25:56 +0000

//
//  CacheService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 01/10/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
import RxSwift


 class MockCacheService: CacheService, Cuckoo.ClassMock {
    
     typealias MocksType = CacheService
    
     typealias Stubbing = __StubbingProxy_CacheService
     typealias Verification = __VerificationProxy_CacheService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: CacheService?

     func enableDefaultImplementation(_ stub: CacheService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func run(_ action: @escaping CachableAction, forKey key: String) -> Observable<CacheServiceResult> {
        
    return cuckoo_manager.call("run(_: @escaping CachableAction, forKey: String) -> Observable<CacheServiceResult>",
            parameters: (action, key),
            escapingParameters: (action, key),
            superclassCall:
                
                super.run(action, forKey: key)
                ,
            defaultCall: __defaultImplStub!.run(action, forKey: key))
        
    }
    
    
    
     override func save(_ data: Data, forKey key: String) -> Observable<CacheServiceResult> {
        
    return cuckoo_manager.call("save(_: Data, forKey: String) -> Observable<CacheServiceResult>",
            parameters: (data, key),
            escapingParameters: (data, key),
            superclassCall:
                
                super.save(data, forKey: key)
                ,
            defaultCall: __defaultImplStub!.save(data, forKey: key))
        
    }
    

	 struct __StubbingProxy_CacheService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func run<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ action: M1, forKey key: M2) -> Cuckoo.ClassStubFunction<(CachableAction, String), Observable<CacheServiceResult>> where M1.MatchedType == CachableAction, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(CachableAction, String)>] = [wrap(matchable: action) { $0.0 }, wrap(matchable: key) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCacheService.self, method: "run(_: @escaping CachableAction, forKey: String) -> Observable<CacheServiceResult>", parameterMatchers: matchers))
	    }
	    
	    func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ data: M1, forKey key: M2) -> Cuckoo.ClassStubFunction<(Data, String), Observable<CacheServiceResult>> where M1.MatchedType == Data, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Data, String)>] = [wrap(matchable: data) { $0.0 }, wrap(matchable: key) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCacheService.self, method: "save(_: Data, forKey: String) -> Observable<CacheServiceResult>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_CacheService: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func run<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ action: M1, forKey key: M2) -> Cuckoo.__DoNotUse<(CachableAction, String), Observable<CacheServiceResult>> where M1.MatchedType == CachableAction, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(CachableAction, String)>] = [wrap(matchable: action) { $0.0 }, wrap(matchable: key) { $0.1 }]
	        return cuckoo_manager.verify("run(_: @escaping CachableAction, forKey: String) -> Observable<CacheServiceResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ data: M1, forKey key: M2) -> Cuckoo.__DoNotUse<(Data, String), Observable<CacheServiceResult>> where M1.MatchedType == Data, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Data, String)>] = [wrap(matchable: data) { $0.0 }, wrap(matchable: key) { $0.1 }]
	        return cuckoo_manager.verify("save(_: Data, forKey: String) -> Observable<CacheServiceResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class CacheServiceStub: CacheService {
    

    

    
     override func run(_ action: @escaping CachableAction, forKey key: String) -> Observable<CacheServiceResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<CacheServiceResult>).self)
    }
    
     override func save(_ data: Data, forKey key: String) -> Observable<CacheServiceResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<CacheServiceResult>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/Lexin/LexinApi/LexinApi.swift at 2020-06-02 16:25:56 +0000

//
//  LexinApi.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import RxSwift


 class MockLexinApi: LexinApi, Cuckoo.ClassMock {
    
     typealias MocksType = LexinApi
    
     typealias Stubbing = __StubbingProxy_LexinApi
     typealias Verification = __VerificationProxy_LexinApi

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinApi?

     func enableDefaultImplementation(_ stub: LexinApi) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func search(_ word: String, with language: String) -> Observable<LexinWordResult> {
        
    return cuckoo_manager.call("search(_: String, with: String) -> Observable<LexinWordResult>",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.search(word, with: language)
                ,
            defaultCall: __defaultImplStub!.search(word, with: language))
        
    }
    
    
    
     override func suggestion(_ word: String, with language: String) -> Observable<SuggestionResult> {
        
    return cuckoo_manager.call("suggestion(_: String, with: String) -> Observable<SuggestionResult>",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.suggestion(word, with: language)
                ,
            defaultCall: __defaultImplStub!.suggestion(word, with: language))
        
    }
    

	 struct __StubbingProxy_LexinApi: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func search<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.ClassStubFunction<(String, String), Observable<LexinWordResult>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinApi.self, method: "search(_: String, with: String) -> Observable<LexinWordResult>", parameterMatchers: matchers))
	    }
	    
	    func suggestion<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.ClassStubFunction<(String, String), Observable<SuggestionResult>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinApi.self, method: "suggestion(_: String, with: String) -> Observable<SuggestionResult>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinApi: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func search<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.__DoNotUse<(String, String), Observable<LexinWordResult>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("search(_: String, with: String) -> Observable<LexinWordResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func suggestion<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.__DoNotUse<(String, String), Observable<SuggestionResult>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("suggestion(_: String, with: String) -> Observable<SuggestionResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinApiStub: LexinApi {
    

    

    
     override func search(_ word: String, with language: String) -> Observable<LexinWordResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<LexinWordResult>).self)
    }
    
     override func suggestion(_ word: String, with language: String) -> Observable<SuggestionResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<SuggestionResult>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/Lexin/LexinApi/LexinApiProvider.swift at 2020-06-02 16:25:56 +0000

//
//  LexinApiProvider.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 16/11/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import RxSwift


 class MockLexinApiProvider: LexinApiProvider, Cuckoo.ClassMock {
    
     typealias MocksType = LexinApiProvider
    
     typealias Stubbing = __StubbingProxy_LexinApiProvider
     typealias Verification = __VerificationProxy_LexinApiProvider

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinApiProvider?

     func enableDefaultImplementation(_ stub: LexinApiProvider) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getApi(by language: Language) -> LexinApi {
        
    return cuckoo_manager.call("getApi(by: Language) -> LexinApi",
            parameters: (language),
            escapingParameters: (language),
            superclassCall:
                
                super.getApi(by: language)
                ,
            defaultCall: __defaultImplStub!.getApi(by: language))
        
    }
    

	 struct __StubbingProxy_LexinApiProvider: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getApi<M1: Cuckoo.Matchable>(by language: M1) -> Cuckoo.ClassStubFunction<(Language), LexinApi> where M1.MatchedType == Language {
	        let matchers: [Cuckoo.ParameterMatcher<(Language)>] = [wrap(matchable: language) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinApiProvider.self, method: "getApi(by: Language) -> LexinApi", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinApiProvider: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getApi<M1: Cuckoo.Matchable>(by language: M1) -> Cuckoo.__DoNotUse<(Language), LexinApi> where M1.MatchedType == Language {
	        let matchers: [Cuckoo.ParameterMatcher<(Language)>] = [wrap(matchable: language) { $0 }]
	        return cuckoo_manager.verify("getApi(by: Language) -> LexinApi", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinApiProviderStub: LexinApiProvider {
    

    

    
     override func getApi(by language: Language) -> LexinApi  {
        return DefaultValueRegistry.defaultValue(for: (LexinApi).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/Lexin/LexinParser/LexinParserSuggestion.swift at 2020-06-02 16:25:56 +0000

//
//  LexinServiceProviderSuggestion.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15.10.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import UIKit


 class MockLexinParserSuggestion: LexinParserSuggestion, Cuckoo.ProtocolMock {
    
     typealias MocksType = LexinParserSuggestion
    
     typealias Stubbing = __StubbingProxy_LexinParserSuggestion
     typealias Verification = __VerificationProxy_LexinParserSuggestion

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: LexinParserSuggestion?

     func enableDefaultImplementation(_ stub: LexinParserSuggestion) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(_: String, with: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word, with: language))
        
    }
    
    
    
     func parse(text: String) throws -> [Suggestion] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [Suggestion]",
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.parse(text: text))
        
    }
    

	 struct __StubbingProxy_LexinParserSuggestion: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.ProtocolStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserSuggestion.self, method: "getRequestParameters(_: String, with: String) -> Network.PostParameters", parameterMatchers: matchers))
	    }
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), [Suggestion]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserSuggestion.self, method: "parse(text: String) throws -> [Suggestion]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinParserSuggestion: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(_: String, with: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [Suggestion]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [Suggestion]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserSuggestionStub: LexinParserSuggestion {
    

    

    
     func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters  {
        return DefaultValueRegistry.defaultValue(for: (Network.PostParameters).self)
    }
    
     func parse(text: String) throws -> [Suggestion]  {
        return DefaultValueRegistry.defaultValue(for: ([Suggestion]).self)
    }
    
}



 class MockLexinParserSuggestionDefault: LexinParserSuggestionDefault, Cuckoo.ClassMock {
    
     typealias MocksType = LexinParserSuggestionDefault
    
     typealias Stubbing = __StubbingProxy_LexinParserSuggestionDefault
     typealias Verification = __VerificationProxy_LexinParserSuggestionDefault

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinParserSuggestionDefault?

     func enableDefaultImplementation(_ stub: LexinParserSuggestionDefault) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(_: String, with: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.getRequestParameters(word, with: language)
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word, with: language))
        
    }
    
    
    
     override func parse(text: String) throws -> [Suggestion] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [Suggestion]",
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                super.parse(text: text)
                ,
            defaultCall: __defaultImplStub!.parse(text: text))
        
    }
    

	 struct __StubbingProxy_LexinParserSuggestionDefault: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.ClassStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserSuggestionDefault.self, method: "getRequestParameters(_: String, with: String) -> Network.PostParameters", parameterMatchers: matchers))
	    }
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubThrowingFunction<(String), [Suggestion]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserSuggestionDefault.self, method: "parse(text: String) throws -> [Suggestion]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinParserSuggestionDefault: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(_: String, with: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [Suggestion]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [Suggestion]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserSuggestionDefaultStub: LexinParserSuggestionDefault {
    

    

    
     override func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters  {
        return DefaultValueRegistry.defaultValue(for: (Network.PostParameters).self)
    }
    
     override func parse(text: String) throws -> [Suggestion]  {
        return DefaultValueRegistry.defaultValue(for: ([Suggestion]).self)
    }
    
}



 class MockLexinParserSuggestionFolkets: LexinParserSuggestionFolkets, Cuckoo.ClassMock {
    
     typealias MocksType = LexinParserSuggestionFolkets
    
     typealias Stubbing = __StubbingProxy_LexinParserSuggestionFolkets
     typealias Verification = __VerificationProxy_LexinParserSuggestionFolkets

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinParserSuggestionFolkets?

     func enableDefaultImplementation(_ stub: LexinParserSuggestionFolkets) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(_: String, with: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.getRequestParameters(word, with: language)
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word, with: language))
        
    }
    
    
    
     override func parse(text: String) throws -> [Suggestion] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [Suggestion]",
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                super.parse(text: text)
                ,
            defaultCall: __defaultImplStub!.parse(text: text))
        
    }
    

	 struct __StubbingProxy_LexinParserSuggestionFolkets: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.ClassStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserSuggestionFolkets.self, method: "getRequestParameters(_: String, with: String) -> Network.PostParameters", parameterMatchers: matchers))
	    }
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubThrowingFunction<(String), [Suggestion]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserSuggestionFolkets.self, method: "parse(text: String) throws -> [Suggestion]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinParserSuggestionFolkets: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(_: String, with: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [Suggestion]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [Suggestion]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserSuggestionFolketsStub: LexinParserSuggestionFolkets {
    

    

    
     override func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters  {
        return DefaultValueRegistry.defaultValue(for: (Network.PostParameters).self)
    }
    
     override func parse(text: String) throws -> [Suggestion]  {
        return DefaultValueRegistry.defaultValue(for: ([Suggestion]).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/Lexin/LexinParser/LexinParserWords.swift at 2020-06-02 16:25:56 +0000

//
//  LexinServiceProviderWords.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 15.10.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import UIKit


 class MockLexinParserWords: LexinParserWords, Cuckoo.ProtocolMock {
    
     typealias MocksType = LexinParserWords
    
     typealias Stubbing = __StubbingProxy_LexinParserWords
     typealias Verification = __VerificationProxy_LexinParserWords

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: LexinParserWords?

     func enableDefaultImplementation(_ stub: LexinParserWords) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(_: String, with: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word, with: language))
        
    }
    
    
    
     func parse(text: String) throws -> [LexinWord] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [LexinWord]",
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.parse(text: text))
        
    }
    

	 struct __StubbingProxy_LexinParserWords: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.ProtocolStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWords.self, method: "getRequestParameters(_: String, with: String) -> Network.PostParameters", parameterMatchers: matchers))
	    }
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), [LexinWord]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWords.self, method: "parse(text: String) throws -> [LexinWord]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinParserWords: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(_: String, with: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinWord]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [LexinWord]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserWordsStub: LexinParserWords {
    

    

    
     func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters  {
        return DefaultValueRegistry.defaultValue(for: (Network.PostParameters).self)
    }
    
     func parse(text: String) throws -> [LexinWord]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinWord]).self)
    }
    
}



 class MockLexinParserWordsDefault: LexinParserWordsDefault, Cuckoo.ClassMock {
    
     typealias MocksType = LexinParserWordsDefault
    
     typealias Stubbing = __StubbingProxy_LexinParserWordsDefault
     typealias Verification = __VerificationProxy_LexinParserWordsDefault

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinParserWordsDefault?

     func enableDefaultImplementation(_ stub: LexinParserWordsDefault) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(_: String, with: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.getRequestParameters(word, with: language)
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word, with: language))
        
    }
    
    
    
     override func parse(text: String) throws -> [LexinWord] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [LexinWord]",
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                super.parse(text: text)
                ,
            defaultCall: __defaultImplStub!.parse(text: text))
        
    }
    

	 struct __StubbingProxy_LexinParserWordsDefault: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.ClassStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWordsDefault.self, method: "getRequestParameters(_: String, with: String) -> Network.PostParameters", parameterMatchers: matchers))
	    }
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubThrowingFunction<(String), [LexinWord]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWordsDefault.self, method: "parse(text: String) throws -> [LexinWord]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinParserWordsDefault: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(_: String, with: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinWord]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [LexinWord]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserWordsDefaultStub: LexinParserWordsDefault {
    

    

    
     override func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters  {
        return DefaultValueRegistry.defaultValue(for: (Network.PostParameters).self)
    }
    
     override func parse(text: String) throws -> [LexinWord]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinWord]).self)
    }
    
}



 class MockLexinParserWordsSwedish: LexinParserWordsSwedish, Cuckoo.ClassMock {
    
     typealias MocksType = LexinParserWordsSwedish
    
     typealias Stubbing = __StubbingProxy_LexinParserWordsSwedish
     typealias Verification = __VerificationProxy_LexinParserWordsSwedish

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinParserWordsSwedish?

     func enableDefaultImplementation(_ stub: LexinParserWordsSwedish) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func parse(text: String) throws -> [LexinWord] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [LexinWord]",
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                super.parse(text: text)
                ,
            defaultCall: __defaultImplStub!.parse(text: text))
        
    }
    
    
    
     override func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(_: String, with: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.getRequestParameters(word, with: language)
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word, with: language))
        
    }
    

	 struct __StubbingProxy_LexinParserWordsSwedish: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubThrowingFunction<(String), [LexinWord]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWordsSwedish.self, method: "parse(text: String) throws -> [LexinWord]", parameterMatchers: matchers))
	    }
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.ClassStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWordsSwedish.self, method: "getRequestParameters(_: String, with: String) -> Network.PostParameters", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinParserWordsSwedish: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinWord]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [LexinWord]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(_: String, with: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserWordsSwedishStub: LexinParserWordsSwedish {
    

    

    
     override func parse(text: String) throws -> [LexinWord]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinWord]).self)
    }
    
     override func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters  {
        return DefaultValueRegistry.defaultValue(for: (Network.PostParameters).self)
    }
    
}



 class MockLexinParserWordsFolkets: LexinParserWordsFolkets, Cuckoo.ClassMock {
    
     typealias MocksType = LexinParserWordsFolkets
    
     typealias Stubbing = __StubbingProxy_LexinParserWordsFolkets
     typealias Verification = __VerificationProxy_LexinParserWordsFolkets

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinParserWordsFolkets?

     func enableDefaultImplementation(_ stub: LexinParserWordsFolkets) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(_: String, with: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.getRequestParameters(word, with: language)
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word, with: language))
        
    }
    
    
    
     override func parse(text: String) throws -> [LexinWord] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [LexinWord]",
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                super.parse(text: text)
                ,
            defaultCall: __defaultImplStub!.parse(text: text))
        
    }
    

	 struct __StubbingProxy_LexinParserWordsFolkets: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.ClassStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWordsFolkets.self, method: "getRequestParameters(_: String, with: String) -> Network.PostParameters", parameterMatchers: matchers))
	    }
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubThrowingFunction<(String), [LexinWord]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWordsFolkets.self, method: "parse(text: String) throws -> [LexinWord]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinParserWordsFolkets: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ word: M1, with language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(_: String, with: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinWord]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [LexinWord]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserWordsFolketsStub: LexinParserWordsFolkets {
    

    

    
     override func getRequestParameters(_ word: String, with language: String) -> Network.PostParameters  {
        return DefaultValueRegistry.defaultValue(for: (Network.PostParameters).self)
    }
    
     override func parse(text: String) throws -> [LexinWord]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinWord]).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/Lexin/LexinService/LexinService.swift at 2020-06-02 16:25:56 +0000

//
//  LexinService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 02.06.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
import RxSwift


 class MockLexinService: LexinService, Cuckoo.ProtocolMock {
    
     typealias MocksType = LexinService
    
     typealias Stubbing = __StubbingProxy_LexinService
     typealias Verification = __VerificationProxy_LexinService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: LexinService?

     func enableDefaultImplementation(_ stub: LexinService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func search(_ word: String) -> Observable<LexinWordResult> {
        
    return cuckoo_manager.call("search(_: String) -> Observable<LexinWordResult>",
            parameters: (word),
            escapingParameters: (word),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.search(word))
        
    }
    
    
    
     func suggestion(_ word: String) -> Observable<SuggestionResult> {
        
    return cuckoo_manager.call("suggestion(_: String) -> Observable<SuggestionResult>",
            parameters: (word),
            escapingParameters: (word),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.suggestion(word))
        
    }
    
    
    
     func language() -> BehaviorSubject<Language> {
        
    return cuckoo_manager.call("language() -> BehaviorSubject<Language>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.language())
        
    }
    

	 struct __StubbingProxy_LexinService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func search<M1: Cuckoo.Matchable>(_ word: M1) -> Cuckoo.ProtocolStubFunction<(String), Observable<LexinWordResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinService.self, method: "search(_: String) -> Observable<LexinWordResult>", parameterMatchers: matchers))
	    }
	    
	    func suggestion<M1: Cuckoo.Matchable>(_ word: M1) -> Cuckoo.ProtocolStubFunction<(String), Observable<SuggestionResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinService.self, method: "suggestion(_: String) -> Observable<SuggestionResult>", parameterMatchers: matchers))
	    }
	    
	    func language() -> Cuckoo.ProtocolStubFunction<(), BehaviorSubject<Language>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinService.self, method: "language() -> BehaviorSubject<Language>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinService: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func search<M1: Cuckoo.Matchable>(_ word: M1) -> Cuckoo.__DoNotUse<(String), Observable<LexinWordResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return cuckoo_manager.verify("search(_: String) -> Observable<LexinWordResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func suggestion<M1: Cuckoo.Matchable>(_ word: M1) -> Cuckoo.__DoNotUse<(String), Observable<SuggestionResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return cuckoo_manager.verify("suggestion(_: String) -> Observable<SuggestionResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func language() -> Cuckoo.__DoNotUse<(), BehaviorSubject<Language>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("language() -> BehaviorSubject<Language>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinServiceStub: LexinService {
    

    

    
     func search(_ word: String) -> Observable<LexinWordResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<LexinWordResult>).self)
    }
    
     func suggestion(_ word: String) -> Observable<SuggestionResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<SuggestionResult>).self)
    }
    
     func language() -> BehaviorSubject<Language>  {
        return DefaultValueRegistry.defaultValue(for: (BehaviorSubject<Language>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/Lexin/LexinService/LexinServiceFormatter.swift at 2020-06-02 16:25:56 +0000

//
//  LexinServiceFormatter.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 02.06.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation


 class MockLexinServiceFormatter: LexinServiceFormatter, Cuckoo.ProtocolMock {
    
     typealias MocksType = LexinServiceFormatter
    
     typealias Stubbing = __StubbingProxy_LexinServiceFormatter
     typealias Verification = __VerificationProxy_LexinServiceFormatter

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: LexinServiceFormatter?

     func enableDefaultImplementation(_ stub: LexinServiceFormatter) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func format(result: LexinWordResult) -> FormattedWordResult {
        
    return cuckoo_manager.call("format(result: LexinWordResult) -> FormattedWordResult",
            parameters: (result),
            escapingParameters: (result),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.format(result: result))
        
    }
    

	 struct __StubbingProxy_LexinServiceFormatter: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func format<M1: Cuckoo.Matchable>(result: M1) -> Cuckoo.ProtocolStubFunction<(LexinWordResult), FormattedWordResult> where M1.MatchedType == LexinWordResult {
	        let matchers: [Cuckoo.ParameterMatcher<(LexinWordResult)>] = [wrap(matchable: result) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceFormatter.self, method: "format(result: LexinWordResult) -> FormattedWordResult", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinServiceFormatter: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func format<M1: Cuckoo.Matchable>(result: M1) -> Cuckoo.__DoNotUse<(LexinWordResult), FormattedWordResult> where M1.MatchedType == LexinWordResult {
	        let matchers: [Cuckoo.ParameterMatcher<(LexinWordResult)>] = [wrap(matchable: result) { $0 }]
	        return cuckoo_manager.verify("format(result: LexinWordResult) -> FormattedWordResult", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinServiceFormatterStub: LexinServiceFormatter {
    

    

    
     func format(result: LexinWordResult) -> FormattedWordResult  {
        return DefaultValueRegistry.defaultValue(for: (FormattedWordResult).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/NetworkService.swift at 2020-06-02 16:25:56 +0000

//
//  NetworkService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 03/10/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
import RxSwift


 class MockNetworkService: NetworkService, Cuckoo.ClassMock {
    
     typealias MocksType = NetworkService
    
     typealias Stubbing = __StubbingProxy_NetworkService
     typealias Verification = __VerificationProxy_NetworkService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: NetworkService?

     func enableDefaultImplementation(_ stub: NetworkService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getRequest(with url: String) -> Observable<NetworkServiceResult> {
        
    return cuckoo_manager.call("getRequest(with: String) -> Observable<NetworkServiceResult>",
            parameters: (url),
            escapingParameters: (url),
            superclassCall:
                
                super.getRequest(with: url)
                ,
            defaultCall: __defaultImplStub!.getRequest(with: url))
        
    }
    
    
    
     override func postRequest(with parameters: Network.PostParameters) -> Observable<NetworkServiceResult> {
        
    return cuckoo_manager.call("postRequest(with: Network.PostParameters) -> Observable<NetworkServiceResult>",
            parameters: (parameters),
            escapingParameters: (parameters),
            superclassCall:
                
                super.postRequest(with: parameters)
                ,
            defaultCall: __defaultImplStub!.postRequest(with: parameters))
        
    }
    

	 struct __StubbingProxy_NetworkService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getRequest<M1: Cuckoo.Matchable>(with url: M1) -> Cuckoo.ClassStubFunction<(String), Observable<NetworkServiceResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetworkService.self, method: "getRequest(with: String) -> Observable<NetworkServiceResult>", parameterMatchers: matchers))
	    }
	    
	    func postRequest<M1: Cuckoo.Matchable>(with parameters: M1) -> Cuckoo.ClassStubFunction<(Network.PostParameters), Observable<NetworkServiceResult>> where M1.MatchedType == Network.PostParameters {
	        let matchers: [Cuckoo.ParameterMatcher<(Network.PostParameters)>] = [wrap(matchable: parameters) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetworkService.self, method: "postRequest(with: Network.PostParameters) -> Observable<NetworkServiceResult>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_NetworkService: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getRequest<M1: Cuckoo.Matchable>(with url: M1) -> Cuckoo.__DoNotUse<(String), Observable<NetworkServiceResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return cuckoo_manager.verify("getRequest(with: String) -> Observable<NetworkServiceResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func postRequest<M1: Cuckoo.Matchable>(with parameters: M1) -> Cuckoo.__DoNotUse<(Network.PostParameters), Observable<NetworkServiceResult>> where M1.MatchedType == Network.PostParameters {
	        let matchers: [Cuckoo.ParameterMatcher<(Network.PostParameters)>] = [wrap(matchable: parameters) { $0 }]
	        return cuckoo_manager.verify("postRequest(with: Network.PostParameters) -> Observable<NetworkServiceResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class NetworkServiceStub: NetworkService {
    

    

    
     override func getRequest(with url: String) -> Observable<NetworkServiceResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<NetworkServiceResult>).self)
    }
    
     override func postRequest(with parameters: Network.PostParameters) -> Observable<NetworkServiceResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<NetworkServiceResult>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/PlayerService.swift at 2020-06-02 16:25:56 +0000

//
//  PlayerService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 13/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
import RxSwift


 class MockPlayerService: PlayerService, Cuckoo.ClassMock {
    
     typealias MocksType = PlayerService
    
     typealias Stubbing = __StubbingProxy_PlayerService
     typealias Verification = __VerificationProxy_PlayerService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: PlayerService?

     func enableDefaultImplementation(_ stub: PlayerService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func playSound(with url: String) -> Observable<PlayerServiceResult> {
        
    return cuckoo_manager.call("playSound(with: String) -> Observable<PlayerServiceResult>",
            parameters: (url),
            escapingParameters: (url),
            superclassCall:
                
                super.playSound(with: url)
                ,
            defaultCall: __defaultImplStub!.playSound(with: url))
        
    }
    

	 struct __StubbingProxy_PlayerService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func playSound<M1: Cuckoo.Matchable>(with url: M1) -> Cuckoo.ClassStubFunction<(String), Observable<PlayerServiceResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPlayerService.self, method: "playSound(with: String) -> Observable<PlayerServiceResult>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_PlayerService: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func playSound<M1: Cuckoo.Matchable>(with url: M1) -> Cuckoo.__DoNotUse<(String), Observable<PlayerServiceResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return cuckoo_manager.verify("playSound(with: String) -> Observable<PlayerServiceResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class PlayerServiceStub: PlayerService {
    

    

    
     override func playSound(with url: String) -> Observable<PlayerServiceResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<PlayerServiceResult>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/SettingsLanguageService.swift at 2020-06-02 16:25:56 +0000

//
//  SettingsLanguageService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 27.12.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import RxSwift


 class MockSettingsLanguageService: SettingsLanguageService, Cuckoo.ClassMock {
    
     typealias MocksType = SettingsLanguageService
    
     typealias Stubbing = __StubbingProxy_SettingsLanguageService
     typealias Verification = __VerificationProxy_SettingsLanguageService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: SettingsLanguageService?

     func enableDefaultImplementation(_ stub: SettingsLanguageService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func update(with language: String) -> Observable<SettingsLanguageResult> {
        
    return cuckoo_manager.call("update(with: String) -> Observable<SettingsLanguageResult>",
            parameters: (language),
            escapingParameters: (language),
            superclassCall:
                
                super.update(with: language)
                ,
            defaultCall: __defaultImplStub!.update(with: language))
        
    }
    
    
    
     override func get(with language: String) -> Observable<SettingsLanguageItemResult> {
        
    return cuckoo_manager.call("get(with: String) -> Observable<SettingsLanguageItemResult>",
            parameters: (language),
            escapingParameters: (language),
            superclassCall:
                
                super.get(with: language)
                ,
            defaultCall: __defaultImplStub!.get(with: language))
        
    }
    

	 struct __StubbingProxy_SettingsLanguageService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func update<M1: Cuckoo.Matchable>(with language: M1) -> Cuckoo.ClassStubFunction<(String), Observable<SettingsLanguageResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: language) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsLanguageService.self, method: "update(with: String) -> Observable<SettingsLanguageResult>", parameterMatchers: matchers))
	    }
	    
	    func get<M1: Cuckoo.Matchable>(with language: M1) -> Cuckoo.ClassStubFunction<(String), Observable<SettingsLanguageItemResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: language) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSettingsLanguageService.self, method: "get(with: String) -> Observable<SettingsLanguageItemResult>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_SettingsLanguageService: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func update<M1: Cuckoo.Matchable>(with language: M1) -> Cuckoo.__DoNotUse<(String), Observable<SettingsLanguageResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: language) { $0 }]
	        return cuckoo_manager.verify("update(with: String) -> Observable<SettingsLanguageResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func get<M1: Cuckoo.Matchable>(with language: M1) -> Cuckoo.__DoNotUse<(String), Observable<SettingsLanguageItemResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: language) { $0 }]
	        return cuckoo_manager.verify("get(with: String) -> Observable<SettingsLanguageItemResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class SettingsLanguageServiceStub: SettingsLanguageService {
    

    

    
     override func update(with language: String) -> Observable<SettingsLanguageResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<SettingsLanguageResult>).self)
    }
    
     override func get(with language: String) -> Observable<SettingsLanguageItemResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<SettingsLanguageItemResult>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/StorageService.swift at 2020-06-02 16:25:56 +0000

//
//  StorageService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 29.11.2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
import RxSwift


 class MockStorageService<T: Codable & Equatable>: StorageService<T>, Cuckoo.ClassMock {
    
     typealias MocksType = StorageService<T>
    
     typealias Stubbing = __StubbingProxy_StorageService
     typealias Verification = __VerificationProxy_StorageService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: StorageService<T>?

     func enableDefaultImplementation(_ stub: StorageService<T>) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func get(where filterFunc: @escaping (T) -> Bool) -> Observable<Result<[T]>> {
        
    return cuckoo_manager.call("get(where: @escaping (T) -> Bool) -> Observable<Result<[T]>>",
            parameters: (filterFunc),
            escapingParameters: (filterFunc),
            superclassCall:
                
                super.get(where: filterFunc)
                ,
            defaultCall: __defaultImplStub!.get(where: filterFunc))
        
    }
    
    
    
     override func add(_ word: T) -> Observable<StorageServiceResult> {
        
    return cuckoo_manager.call("add(_: T) -> Observable<StorageServiceResult>",
            parameters: (word),
            escapingParameters: (word),
            superclassCall:
                
                super.add(word)
                ,
            defaultCall: __defaultImplStub!.add(word))
        
    }
    
    
    
     override func remove(_ word: T) -> Observable<StorageServiceResult> {
        
    return cuckoo_manager.call("remove(_: T) -> Observable<StorageServiceResult>",
            parameters: (word),
            escapingParameters: (word),
            superclassCall:
                
                super.remove(word)
                ,
            defaultCall: __defaultImplStub!.remove(word))
        
    }
    
    
    
     override func remove(at index: Int) -> Observable<StorageServiceResult> {
        
    return cuckoo_manager.call("remove(at: Int) -> Observable<StorageServiceResult>",
            parameters: (index),
            escapingParameters: (index),
            superclassCall:
                
                super.remove(at: index)
                ,
            defaultCall: __defaultImplStub!.remove(at: index))
        
    }
    
    
    
     override func contains(_ word: T) -> Observable<StorageServiceResult> {
        
    return cuckoo_manager.call("contains(_: T) -> Observable<StorageServiceResult>",
            parameters: (word),
            escapingParameters: (word),
            superclassCall:
                
                super.contains(word)
                ,
            defaultCall: __defaultImplStub!.contains(word))
        
    }
    

	 struct __StubbingProxy_StorageService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func get<M1: Cuckoo.Matchable>(where filterFunc: M1) -> Cuckoo.ClassStubFunction<((T) -> Bool), Observable<Result<[T]>>> where M1.MatchedType == (T) -> Bool {
	        let matchers: [Cuckoo.ParameterMatcher<((T) -> Bool)>] = [wrap(matchable: filterFunc) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockStorageService.self, method: "get(where: @escaping (T) -> Bool) -> Observable<Result<[T]>>", parameterMatchers: matchers))
	    }
	    
	    func add<M1: Cuckoo.Matchable>(_ word: M1) -> Cuckoo.ClassStubFunction<(T), Observable<StorageServiceResult>> where M1.MatchedType == T {
	        let matchers: [Cuckoo.ParameterMatcher<(T)>] = [wrap(matchable: word) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockStorageService.self, method: "add(_: T) -> Observable<StorageServiceResult>", parameterMatchers: matchers))
	    }
	    
	    func remove<M1: Cuckoo.Matchable>(_ word: M1) -> Cuckoo.ClassStubFunction<(T), Observable<StorageServiceResult>> where M1.MatchedType == T {
	        let matchers: [Cuckoo.ParameterMatcher<(T)>] = [wrap(matchable: word) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockStorageService.self, method: "remove(_: T) -> Observable<StorageServiceResult>", parameterMatchers: matchers))
	    }
	    
	    func remove<M1: Cuckoo.Matchable>(at index: M1) -> Cuckoo.ClassStubFunction<(Int), Observable<StorageServiceResult>> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: index) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockStorageService.self, method: "remove(at: Int) -> Observable<StorageServiceResult>", parameterMatchers: matchers))
	    }
	    
	    func contains<M1: Cuckoo.Matchable>(_ word: M1) -> Cuckoo.ClassStubFunction<(T), Observable<StorageServiceResult>> where M1.MatchedType == T {
	        let matchers: [Cuckoo.ParameterMatcher<(T)>] = [wrap(matchable: word) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockStorageService.self, method: "contains(_: T) -> Observable<StorageServiceResult>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_StorageService: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func get<M1: Cuckoo.Matchable>(where filterFunc: M1) -> Cuckoo.__DoNotUse<((T) -> Bool), Observable<Result<[T]>>> where M1.MatchedType == (T) -> Bool {
	        let matchers: [Cuckoo.ParameterMatcher<((T) -> Bool)>] = [wrap(matchable: filterFunc) { $0 }]
	        return cuckoo_manager.verify("get(where: @escaping (T) -> Bool) -> Observable<Result<[T]>>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func add<M1: Cuckoo.Matchable>(_ word: M1) -> Cuckoo.__DoNotUse<(T), Observable<StorageServiceResult>> where M1.MatchedType == T {
	        let matchers: [Cuckoo.ParameterMatcher<(T)>] = [wrap(matchable: word) { $0 }]
	        return cuckoo_manager.verify("add(_: T) -> Observable<StorageServiceResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func remove<M1: Cuckoo.Matchable>(_ word: M1) -> Cuckoo.__DoNotUse<(T), Observable<StorageServiceResult>> where M1.MatchedType == T {
	        let matchers: [Cuckoo.ParameterMatcher<(T)>] = [wrap(matchable: word) { $0 }]
	        return cuckoo_manager.verify("remove(_: T) -> Observable<StorageServiceResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func remove<M1: Cuckoo.Matchable>(at index: M1) -> Cuckoo.__DoNotUse<(Int), Observable<StorageServiceResult>> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: index) { $0 }]
	        return cuckoo_manager.verify("remove(at: Int) -> Observable<StorageServiceResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func contains<M1: Cuckoo.Matchable>(_ word: M1) -> Cuckoo.__DoNotUse<(T), Observable<StorageServiceResult>> where M1.MatchedType == T {
	        let matchers: [Cuckoo.ParameterMatcher<(T)>] = [wrap(matchable: word) { $0 }]
	        return cuckoo_manager.verify("contains(_: T) -> Observable<StorageServiceResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class StorageServiceStub<T: Codable & Equatable>: StorageService<T> {
    

    

    
     override func get(where filterFunc: @escaping (T) -> Bool) -> Observable<Result<[T]>>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Result<[T]>>).self)
    }
    
     override func add(_ word: T) -> Observable<StorageServiceResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<StorageServiceResult>).self)
    }
    
     override func remove(_ word: T) -> Observable<StorageServiceResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<StorageServiceResult>).self)
    }
    
     override func remove(at index: Int) -> Observable<StorageServiceResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<StorageServiceResult>).self)
    }
    
     override func contains(_ word: T) -> Observable<StorageServiceResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<StorageServiceResult>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/WordsService.swift at 2020-06-02 16:25:56 +0000

//
//  WordsService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/12/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import RxSwift


 class MockWordsService: WordsService, Cuckoo.ClassMock {
    
     typealias MocksType = WordsService
    
     typealias Stubbing = __StubbingProxy_WordsService
     typealias Verification = __VerificationProxy_WordsService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: WordsService?

     func enableDefaultImplementation(_ stub: WordsService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public override func search(_ word: String) -> Observable<FoundWordResult> {
        
    return cuckoo_manager.call("search(_: String) -> Observable<FoundWordResult>",
            parameters: (word),
            escapingParameters: (word),
            superclassCall:
                
                super.search(word)
                ,
            defaultCall: __defaultImplStub!.search(word))
        
    }
    
    
    
    public override func language() -> BehaviorSubject<Language> {
        
    return cuckoo_manager.call("language() -> BehaviorSubject<Language>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.language()
                ,
            defaultCall: __defaultImplStub!.language())
        
    }
    

	 struct __StubbingProxy_WordsService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func search<M1: Cuckoo.Matchable>(_ word: M1) -> Cuckoo.ClassStubFunction<(String), Observable<FoundWordResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockWordsService.self, method: "search(_: String) -> Observable<FoundWordResult>", parameterMatchers: matchers))
	    }
	    
	    func language() -> Cuckoo.ClassStubFunction<(), BehaviorSubject<Language>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockWordsService.self, method: "language() -> BehaviorSubject<Language>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_WordsService: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func search<M1: Cuckoo.Matchable>(_ word: M1) -> Cuckoo.__DoNotUse<(String), Observable<FoundWordResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return cuckoo_manager.verify("search(_: String) -> Observable<FoundWordResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func language() -> Cuckoo.__DoNotUse<(), BehaviorSubject<Language>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("language() -> BehaviorSubject<Language>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class WordsServiceStub: WordsService {
    

    

    
    public override func search(_ word: String) -> Observable<FoundWordResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<FoundWordResult>).self)
    }
    
    public override func language() -> BehaviorSubject<Language>  {
        return DefaultValueRegistry.defaultValue(for: (BehaviorSubject<Language>).self)
    }
    
}

