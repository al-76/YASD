// MARK: - Mocks generated from file: YASD/Platform/DataCache.swift at 2019-10-14 15:03:51 +0000

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
    

    

    

    
    
    
     override func save(key: String, data: Data) -> Observable<Data> {
        
    return cuckoo_manager.call("save(key: String, data: Data) -> Observable<Data>",
            parameters: (key, data),
            escapingParameters: (key, data),
            superclassCall:
                
                super.save(key: key, data: data)
                ,
            defaultCall: __defaultImplStub!.save(key: key, data: data))
        
    }
    
    
    
     override func load(key: String) -> Observable<Data?> {
        
    return cuckoo_manager.call("load(key: String) -> Observable<Data?>",
            parameters: (key),
            escapingParameters: (key),
            superclassCall:
                
                super.load(key: key)
                ,
            defaultCall: __defaultImplStub!.load(key: key))
        
    }
    

	 struct __StubbingProxy_DataCache: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(key: M1, data: M2) -> Cuckoo.ClassStubFunction<(String, Data), Observable<Data>> where M1.MatchedType == String, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Data)>] = [wrap(matchable: key) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDataCache.self, method: "save(key: String, data: Data) -> Observable<Data>", parameterMatchers: matchers))
	    }
	    
	    func load<M1: Cuckoo.Matchable>(key: M1) -> Cuckoo.ClassStubFunction<(String), Observable<Data?>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDataCache.self, method: "load(key: String) -> Observable<Data?>", parameterMatchers: matchers))
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
	    func save<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(key: M1, data: M2) -> Cuckoo.__DoNotUse<(String, Data), Observable<Data>> where M1.MatchedType == String, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Data)>] = [wrap(matchable: key) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return cuckoo_manager.verify("save(key: String, data: Data) -> Observable<Data>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func load<M1: Cuckoo.Matchable>(key: M1) -> Cuckoo.__DoNotUse<(String), Observable<Data?>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: key) { $0 }]
	        return cuckoo_manager.verify("load(key: String) -> Observable<Data?>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DataCacheStub: DataCache {
    

    

    
     override func save(key: String, data: Data) -> Observable<Data>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Data>).self)
    }
    
     override func load(key: String) -> Observable<Data?>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Data?>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Platform/Files.swift at 2019-10-14 15:03:51 +0000

//
//  Files.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 13/09/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
import RxSwift


 class MockFiles: Files, Cuckoo.ClassMock {
    
     typealias MocksType = Files
    
     typealias Stubbing = __StubbingProxy_Files
     typealias Verification = __VerificationProxy_Files

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: Files?

     func enableDefaultImplementation(_ stub: Files) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func createTempFile(name: String) throws -> URL {
        
    return try cuckoo_manager.callThrows("createTempFile(name: String) throws -> URL",
            parameters: (name),
            escapingParameters: (name),
            superclassCall:
                
                super.createTempFile(name: name)
                ,
            defaultCall: __defaultImplStub!.createTempFile(name: name))
        
    }
    
    
    
     override func writeData(to: URL, data: Data) throws {
        
    return try cuckoo_manager.callThrows("writeData(to: URL, data: Data) throws",
            parameters: (to, data),
            escapingParameters: (to, data),
            superclassCall:
                
                super.writeData(to: to, data: data)
                ,
            defaultCall: __defaultImplStub!.writeData(to: to, data: data))
        
    }
    

	 struct __StubbingProxy_Files: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func createTempFile<M1: Cuckoo.Matchable>(name: M1) -> Cuckoo.ClassStubThrowingFunction<(String), URL> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: name) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFiles.self, method: "createTempFile(name: String) throws -> URL", parameterMatchers: matchers))
	    }
	    
	    func writeData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(to: M1, data: M2) -> Cuckoo.ClassStubNoReturnThrowingFunction<(URL, Data)> where M1.MatchedType == URL, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(URL, Data)>] = [wrap(matchable: to) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFiles.self, method: "writeData(to: URL, data: Data) throws", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_Files: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func createTempFile<M1: Cuckoo.Matchable>(name: M1) -> Cuckoo.__DoNotUse<(String), URL> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: name) { $0 }]
	        return cuckoo_manager.verify("createTempFile(name: String) throws -> URL", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func writeData<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(to: M1, data: M2) -> Cuckoo.__DoNotUse<(URL, Data), Void> where M1.MatchedType == URL, M2.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(URL, Data)>] = [wrap(matchable: to) { $0.0 }, wrap(matchable: data) { $0.1 }]
	        return cuckoo_manager.verify("writeData(to: URL, data: Data) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FilesStub: Files {
    

    

    
     override func createTempFile(name: String) throws -> URL  {
        return DefaultValueRegistry.defaultValue(for: (URL).self)
    }
    
     override func writeData(to: URL, data: Data) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Platform/HtmlParser.swift at 2019-10-14 15:03:51 +0000


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


// MARK: - Mocks generated from file: YASD/Platform/Markdown.swift at 2019-10-14 15:03:51 +0000

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


// MARK: - Mocks generated from file: YASD/Platform/Network.swift at 2019-10-14 15:03:51 +0000

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
    

    

    

    
    
    
     override func postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<Data> {
        
    return cuckoo_manager.call("postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<Data>",
            parameters: (url, parameters),
            escapingParameters: (url, parameters),
            superclassCall:
                
                super.postRequest(url: url, parameters: parameters)
                ,
            defaultCall: __defaultImplStub!.postRequest(url: url, parameters: parameters))
        
    }
    
    
    
     override func getRequest(url: String) -> Observable<Data> {
        
    return cuckoo_manager.call("getRequest(url: String) -> Observable<Data>",
            parameters: (url),
            escapingParameters: (url),
            superclassCall:
                
                super.getRequest(url: url)
                ,
            defaultCall: __defaultImplStub!.getRequest(url: url))
        
    }
    

	 struct __StubbingProxy_Network: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func postRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(url: M1, parameters: M2) -> Cuckoo.ClassStubFunction<(String, (String?, [String: String]?)?), Observable<Data>> where M1.MatchedType == String, M2.OptionalMatchedType == (String?, [String: String]?) {
	        let matchers: [Cuckoo.ParameterMatcher<(String, (String?, [String: String]?)?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetwork.self, method: "postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<Data>", parameterMatchers: matchers))
	    }
	    
	    func getRequest<M1: Cuckoo.Matchable>(url: M1) -> Cuckoo.ClassStubFunction<(String), Observable<Data>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetwork.self, method: "getRequest(url: String) -> Observable<Data>", parameterMatchers: matchers))
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
	    func postRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(url: M1, parameters: M2) -> Cuckoo.__DoNotUse<(String, (String?, [String: String]?)?), Observable<Data>> where M1.MatchedType == String, M2.OptionalMatchedType == (String?, [String: String]?) {
	        let matchers: [Cuckoo.ParameterMatcher<(String, (String?, [String: String]?)?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return cuckoo_manager.verify("postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<Data>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRequest<M1: Cuckoo.Matchable>(url: M1) -> Cuckoo.__DoNotUse<(String), Observable<Data>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return cuckoo_manager.verify("getRequest(url: String) -> Observable<Data>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class NetworkStub: Network {
    

    

    
     override func postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<Data>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Data>).self)
    }
    
     override func getRequest(url: String) -> Observable<Data>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Data>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Platform/Player.swift at 2019-10-14 15:03:51 +0000

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
    

    

    
    
    
     override func play(data: Data) throws {
        
    return try cuckoo_manager.callThrows("play(data: Data) throws",
            parameters: (data),
            escapingParameters: (data),
            superclassCall:
                
                super.play(data: data)
                ,
            defaultCall: __defaultImplStub!.play(data: data))
        
    }
    

	 struct __StubbingProxy_Player: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var player: Cuckoo.ClassToBeStubbedOptionalProperty<MockPlayer, AVAudioPlayer> {
	        return .init(manager: cuckoo_manager, name: "player")
	    }
	    
	    
	    func play<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<(Data)> where M1.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(Data)>] = [wrap(matchable: data) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPlayer.self, method: "play(data: Data) throws", parameterMatchers: matchers))
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
	    func play<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.__DoNotUse<(Data), Void> where M1.MatchedType == Data {
	        let matchers: [Cuckoo.ParameterMatcher<(Data)>] = [wrap(matchable: data) { $0 }]
	        return cuckoo_manager.verify("play(data: Data) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    

    

    
     override func play(data: Data) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Platform/Storage.swift at 2019-10-14 15:03:51 +0000

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


// MARK: - Mocks generated from file: YASD/Service/CacheService.swift at 2019-10-14 15:03:51 +0000

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
    

    

    

    
    
    
     override func runAction(key: String, action: @escaping CachableAction) -> Observable<Data> {
        
    return cuckoo_manager.call("runAction(key: String, action: @escaping CachableAction) -> Observable<Data>",
            parameters: (key, action),
            escapingParameters: (key, action),
            superclassCall:
                
                super.runAction(key: key, action: action)
                ,
            defaultCall: __defaultImplStub!.runAction(key: key, action: action))
        
    }
    

	 struct __StubbingProxy_CacheService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func runAction<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(key: M1, action: M2) -> Cuckoo.ClassStubFunction<(String, CachableAction), Observable<Data>> where M1.MatchedType == String, M2.MatchedType == CachableAction {
	        let matchers: [Cuckoo.ParameterMatcher<(String, CachableAction)>] = [wrap(matchable: key) { $0.0 }, wrap(matchable: action) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCacheService.self, method: "runAction(key: String, action: @escaping CachableAction) -> Observable<Data>", parameterMatchers: matchers))
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
	    func runAction<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(key: M1, action: M2) -> Cuckoo.__DoNotUse<(String, CachableAction), Observable<Data>> where M1.MatchedType == String, M2.MatchedType == CachableAction {
	        let matchers: [Cuckoo.ParameterMatcher<(String, CachableAction)>] = [wrap(matchable: key) { $0.0 }, wrap(matchable: action) { $0.1 }]
	        return cuckoo_manager.verify("runAction(key: String, action: @escaping CachableAction) -> Observable<Data>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class CacheServiceStub: CacheService {
    

    

    
     override func runAction(key: String, action: @escaping CachableAction) -> Observable<Data>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Data>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/LexinService/LexinService.swift at 2019-10-14 15:03:51 +0000

//
//  LexinService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import RxSwift


 class MockLexinServiceParameters: LexinServiceParameters, Cuckoo.ClassMock {
    
     typealias MocksType = LexinServiceParameters
    
     typealias Stubbing = __StubbingProxy_LexinServiceParameters
     typealias Verification = __VerificationProxy_LexinServiceParameters

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinServiceParameters?

     func enableDefaultImplementation(_ stub: LexinServiceParameters) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func load()  {
        
    return cuckoo_manager.call("load()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.load()
                ,
            defaultCall: __defaultImplStub!.load())
        
    }
    
    
    
     override func get() -> String {
        
    return cuckoo_manager.call("get() -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.get()
                ,
            defaultCall: __defaultImplStub!.get())
        
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
    
    
    
     override func setLanguage(language: Language)  {
        
    return cuckoo_manager.call("setLanguage(language: Language)",
            parameters: (language),
            escapingParameters: (language),
            superclassCall:
                
                super.setLanguage(language: language)
                ,
            defaultCall: __defaultImplStub!.setLanguage(language: language))
        
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
    

	 struct __StubbingProxy_LexinServiceParameters: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func load() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParameters.self, method: "load()", parameterMatchers: matchers))
	    }
	    
	    func get() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParameters.self, method: "get() -> String", parameterMatchers: matchers))
	    }
	    
	    func getLanguageCode() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParameters.self, method: "getLanguageCode() -> String", parameterMatchers: matchers))
	    }
	    
	    func setLanguage<M1: Cuckoo.Matchable>(language: M1) -> Cuckoo.ClassStubNoReturnFunction<(Language)> where M1.MatchedType == Language {
	        let matchers: [Cuckoo.ParameterMatcher<(Language)>] = [wrap(matchable: language) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParameters.self, method: "setLanguage(language: Language)", parameterMatchers: matchers))
	    }
	    
	    func getLanguage() -> Cuckoo.ClassStubFunction<(), Language> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParameters.self, method: "getLanguage() -> Language", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinServiceParameters: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func load() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("load()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func get() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("get() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getLanguageCode() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getLanguageCode() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setLanguage<M1: Cuckoo.Matchable>(language: M1) -> Cuckoo.__DoNotUse<(Language), Void> where M1.MatchedType == Language {
	        let matchers: [Cuckoo.ParameterMatcher<(Language)>] = [wrap(matchable: language) { $0 }]
	        return cuckoo_manager.verify("setLanguage(language: Language)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getLanguage() -> Cuckoo.__DoNotUse<(), Language> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getLanguage() -> Language", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinServiceParametersStub: LexinServiceParameters {
    

    

    
     override func load()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func get() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     override func getLanguageCode() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     override func setLanguage(language: Language)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func getLanguage() -> Language  {
        return DefaultValueRegistry.defaultValue(for: (Language).self)
    }
    
}



 class MockLexinService: LexinService, Cuckoo.ClassMock {
    
     typealias MocksType = LexinService
    
     typealias Stubbing = __StubbingProxy_LexinService
     typealias Verification = __VerificationProxy_LexinService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinService?

     func enableDefaultImplementation(_ stub: LexinService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func search(word: String) -> Observable<LexinServiceResult> {
        
    return cuckoo_manager.call("search(word: String) -> Observable<LexinServiceResult>",
            parameters: (word),
            escapingParameters: (word),
            superclassCall:
                
                super.search(word: word)
                ,
            defaultCall: __defaultImplStub!.search(word: word))
        
    }
    

	 struct __StubbingProxy_LexinService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func search<M1: Cuckoo.Matchable>(word: M1) -> Cuckoo.ClassStubFunction<(String), Observable<LexinServiceResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinService.self, method: "search(word: String) -> Observable<LexinServiceResult>", parameterMatchers: matchers))
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
	    func search<M1: Cuckoo.Matchable>(word: M1) -> Cuckoo.__DoNotUse<(String), Observable<LexinServiceResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return cuckoo_manager.verify("search(word: String) -> Observable<LexinServiceResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinServiceStub: LexinService {
    

    

    
     override func search(word: String) -> Observable<LexinServiceResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<LexinServiceResult>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/LexinService/LexinServiceFormatter.swift at 2019-10-14 15:03:51 +0000

//
//  LexinService+Format.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 07/06/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
import RxSwift


 class MockFormattedLexinService: FormattedLexinService, Cuckoo.ClassMock {
    
     typealias MocksType = FormattedLexinService
    
     typealias Stubbing = __StubbingProxy_FormattedLexinService
     typealias Verification = __VerificationProxy_FormattedLexinService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: FormattedLexinService?

     func enableDefaultImplementation(_ stub: FormattedLexinService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func load()  {
        
    return cuckoo_manager.call("load()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.load()
                ,
            defaultCall: __defaultImplStub!.load())
        
    }
    
    
    
     override func search(word: String) -> Observable<LexinServiceResultFormatted> {
        
    return cuckoo_manager.call("search(word: String) -> Observable<LexinServiceResultFormatted>",
            parameters: (word),
            escapingParameters: (word),
            superclassCall:
                
                super.search(word: word)
                ,
            defaultCall: __defaultImplStub!.search(word: word))
        
    }
    
    
    
     override func language() -> BehaviorSubject<LexinServiceParameters.Language> {
        
    return cuckoo_manager.call("language() -> BehaviorSubject<LexinServiceParameters.Language>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.language()
                ,
            defaultCall: __defaultImplStub!.language())
        
    }
    

	 struct __StubbingProxy_FormattedLexinService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func load() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockFormattedLexinService.self, method: "load()", parameterMatchers: matchers))
	    }
	    
	    func search<M1: Cuckoo.Matchable>(word: M1) -> Cuckoo.ClassStubFunction<(String), Observable<LexinServiceResultFormatted>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFormattedLexinService.self, method: "search(word: String) -> Observable<LexinServiceResultFormatted>", parameterMatchers: matchers))
	    }
	    
	    func language() -> Cuckoo.ClassStubFunction<(), BehaviorSubject<LexinServiceParameters.Language>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockFormattedLexinService.self, method: "language() -> BehaviorSubject<LexinServiceParameters.Language>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FormattedLexinService: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func load() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("load()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func search<M1: Cuckoo.Matchable>(word: M1) -> Cuckoo.__DoNotUse<(String), Observable<LexinServiceResultFormatted>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return cuckoo_manager.verify("search(word: String) -> Observable<LexinServiceResultFormatted>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func language() -> Cuckoo.__DoNotUse<(), BehaviorSubject<LexinServiceParameters.Language>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("language() -> BehaviorSubject<LexinServiceParameters.Language>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FormattedLexinServiceStub: FormattedLexinService {
    

    

    
     override func load()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func search(word: String) -> Observable<LexinServiceResultFormatted>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<LexinServiceResultFormatted>).self)
    }
    
     override func language() -> BehaviorSubject<LexinServiceParameters.Language>  {
        return DefaultValueRegistry.defaultValue(for: (BehaviorSubject<LexinServiceParameters.Language>).self)
    }
    
}



 class MockLexinServiceFormatter: LexinServiceFormatter, Cuckoo.ClassMock {
    
     typealias MocksType = LexinServiceFormatter
    
     typealias Stubbing = __StubbingProxy_LexinServiceFormatter
     typealias Verification = __VerificationProxy_LexinServiceFormatter

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinServiceFormatter?

     func enableDefaultImplementation(_ stub: LexinServiceFormatter) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func format(result: LexinServiceResult) -> LexinServiceResultFormatted {
        
    return cuckoo_manager.call("format(result: LexinServiceResult) -> LexinServiceResultFormatted",
            parameters: (result),
            escapingParameters: (result),
            superclassCall:
                
                super.format(result: result)
                ,
            defaultCall: __defaultImplStub!.format(result: result))
        
    }
    

	 struct __StubbingProxy_LexinServiceFormatter: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func format<M1: Cuckoo.Matchable>(result: M1) -> Cuckoo.ClassStubFunction<(LexinServiceResult), LexinServiceResultFormatted> where M1.MatchedType == LexinServiceResult {
	        let matchers: [Cuckoo.ParameterMatcher<(LexinServiceResult)>] = [wrap(matchable: result) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceFormatter.self, method: "format(result: LexinServiceResult) -> LexinServiceResultFormatted", parameterMatchers: matchers))
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
	    func format<M1: Cuckoo.Matchable>(result: M1) -> Cuckoo.__DoNotUse<(LexinServiceResult), LexinServiceResultFormatted> where M1.MatchedType == LexinServiceResult {
	        let matchers: [Cuckoo.ParameterMatcher<(LexinServiceResult)>] = [wrap(matchable: result) { $0 }]
	        return cuckoo_manager.verify("format(result: LexinServiceResult) -> LexinServiceResultFormatted", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinServiceFormatterStub: LexinServiceFormatter {
    

    

    
     override func format(result: LexinServiceResult) -> LexinServiceResultFormatted  {
        return DefaultValueRegistry.defaultValue(for: (LexinServiceResultFormatted).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/LexinService/LexinServiceProvider.swift at 2019-10-14 15:03:51 +0000

//
//  LexinServiceProvider.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 13/08/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
import UIKit


 class MockLexinServiceProvider: LexinServiceProvider, Cuckoo.ClassMock {
    
     typealias MocksType = LexinServiceProvider
    
     typealias Stubbing = __StubbingProxy_LexinServiceProvider
     typealias Verification = __VerificationProxy_LexinServiceProvider

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinServiceProvider?

     func enableDefaultImplementation(_ stub: LexinServiceProvider) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getParser(language: LexinServiceParameters.Language) -> LexinServiceParser {
        
    return cuckoo_manager.call("getParser(language: LexinServiceParameters.Language) -> LexinServiceParser",
            parameters: (language),
            escapingParameters: (language),
            superclassCall:
                
                super.getParser(language: language)
                ,
            defaultCall: __defaultImplStub!.getParser(language: language))
        
    }
    

	 struct __StubbingProxy_LexinServiceProvider: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getParser<M1: Cuckoo.Matchable>(language: M1) -> Cuckoo.ClassStubFunction<(LexinServiceParameters.Language), LexinServiceParser> where M1.MatchedType == LexinServiceParameters.Language {
	        let matchers: [Cuckoo.ParameterMatcher<(LexinServiceParameters.Language)>] = [wrap(matchable: language) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceProvider.self, method: "getParser(language: LexinServiceParameters.Language) -> LexinServiceParser", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinServiceProvider: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getParser<M1: Cuckoo.Matchable>(language: M1) -> Cuckoo.__DoNotUse<(LexinServiceParameters.Language), LexinServiceParser> where M1.MatchedType == LexinServiceParameters.Language {
	        let matchers: [Cuckoo.ParameterMatcher<(LexinServiceParameters.Language)>] = [wrap(matchable: language) { $0 }]
	        return cuckoo_manager.verify("getParser(language: LexinServiceParameters.Language) -> LexinServiceParser", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinServiceProviderStub: LexinServiceProvider {
    

    

    
     override func getParser(language: LexinServiceParameters.Language) -> LexinServiceParser  {
        return DefaultValueRegistry.defaultValue(for: (LexinServiceParser).self)
    }
    
}



 class MockLexinServiceParser: LexinServiceParser, Cuckoo.ProtocolMock {
    
     typealias MocksType = LexinServiceParser
    
     typealias Stubbing = __StubbingProxy_LexinServiceParser
     typealias Verification = __VerificationProxy_LexinServiceParser

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: LexinServiceParser?

     func enableDefaultImplementation(_ stub: LexinServiceParser) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getUrl() -> String {
        
    return cuckoo_manager.call("getUrl() -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getUrl())
        
    }
    
    
    
     func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?) {
        
    return cuckoo_manager.call("getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)",
            parameters: (word, parameters),
            escapingParameters: (word, parameters),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word: word, parameters: parameters))
        
    }
    
    
    
     func parseHtml(text: String) throws -> [LexinServiceResultItem] {
        
    return try cuckoo_manager.callThrows("parseHtml(text: String) throws -> [LexinServiceResultItem]",
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.parseHtml(text: text))
        
    }
    

	 struct __StubbingProxy_LexinServiceParser: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getUrl() -> Cuckoo.ProtocolStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParser.self, method: "getUrl() -> String", parameterMatchers: matchers))
	    }
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, parameters: M2) -> Cuckoo.ProtocolStubFunction<(String, String), (String?, [String: String]?)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParser.self, method: "getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)", parameterMatchers: matchers))
	    }
	    
	    func parseHtml<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), [LexinServiceResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParser.self, method: "parseHtml(text: String) throws -> [LexinServiceResultItem]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinServiceParser: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getUrl() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getUrl() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, parameters: M2) -> Cuckoo.__DoNotUse<(String, String), (String?, [String: String]?)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parseHtml<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinServiceResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parseHtml(text: String) throws -> [LexinServiceResultItem]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinServiceParserStub: LexinServiceParser {
    

    

    
     func getUrl() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)  {
        return DefaultValueRegistry.defaultValue(for: ((String?, [String: String]?)).self)
    }
    
     func parseHtml(text: String) throws -> [LexinServiceResultItem]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinServiceResultItem]).self)
    }
    
}



 class MockLexinServiceParserDefault: LexinServiceParserDefault, Cuckoo.ClassMock {
    
     typealias MocksType = LexinServiceParserDefault
    
     typealias Stubbing = __StubbingProxy_LexinServiceParserDefault
     typealias Verification = __VerificationProxy_LexinServiceParserDefault

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinServiceParserDefault?

     func enableDefaultImplementation(_ stub: LexinServiceParserDefault) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getUrl() -> String {
        
    return cuckoo_manager.call("getUrl() -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getUrl()
                ,
            defaultCall: __defaultImplStub!.getUrl())
        
    }
    
    
    
     override func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?) {
        
    return cuckoo_manager.call("getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)",
            parameters: (word, parameters),
            escapingParameters: (word, parameters),
            superclassCall:
                
                super.getRequestParameters(word: word, parameters: parameters)
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word: word, parameters: parameters))
        
    }
    
    
    
     override func parseHtml(text: String) throws -> [LexinServiceResultItem] {
        
    return try cuckoo_manager.callThrows("parseHtml(text: String) throws -> [LexinServiceResultItem]",
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                super.parseHtml(text: text)
                ,
            defaultCall: __defaultImplStub!.parseHtml(text: text))
        
    }
    

	 struct __StubbingProxy_LexinServiceParserDefault: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getUrl() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParserDefault.self, method: "getUrl() -> String", parameterMatchers: matchers))
	    }
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, parameters: M2) -> Cuckoo.ClassStubFunction<(String, String), (String?, [String: String]?)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParserDefault.self, method: "getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)", parameterMatchers: matchers))
	    }
	    
	    func parseHtml<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubThrowingFunction<(String), [LexinServiceResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParserDefault.self, method: "parseHtml(text: String) throws -> [LexinServiceResultItem]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinServiceParserDefault: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getUrl() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getUrl() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, parameters: M2) -> Cuckoo.__DoNotUse<(String, String), (String?, [String: String]?)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parseHtml<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinServiceResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parseHtml(text: String) throws -> [LexinServiceResultItem]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinServiceParserDefaultStub: LexinServiceParserDefault {
    

    

    
     override func getUrl() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     override func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)  {
        return DefaultValueRegistry.defaultValue(for: ((String?, [String: String]?)).self)
    }
    
     override func parseHtml(text: String) throws -> [LexinServiceResultItem]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinServiceResultItem]).self)
    }
    
}



 class MockLexinServiceParserSwedish: LexinServiceParserSwedish, Cuckoo.ClassMock {
    
     typealias MocksType = LexinServiceParserSwedish
    
     typealias Stubbing = __StubbingProxy_LexinServiceParserSwedish
     typealias Verification = __VerificationProxy_LexinServiceParserSwedish

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinServiceParserSwedish?

     func enableDefaultImplementation(_ stub: LexinServiceParserSwedish) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func parseHtml(text: String) throws -> [LexinServiceResultItem] {
        
    return try cuckoo_manager.callThrows("parseHtml(text: String) throws -> [LexinServiceResultItem]",
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                super.parseHtml(text: text)
                ,
            defaultCall: __defaultImplStub!.parseHtml(text: text))
        
    }
    
    
    
     override func getUrl() -> String {
        
    return cuckoo_manager.call("getUrl() -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getUrl()
                ,
            defaultCall: __defaultImplStub!.getUrl())
        
    }
    
    
    
     override func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?) {
        
    return cuckoo_manager.call("getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)",
            parameters: (word, parameters),
            escapingParameters: (word, parameters),
            superclassCall:
                
                super.getRequestParameters(word: word, parameters: parameters)
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word: word, parameters: parameters))
        
    }
    

	 struct __StubbingProxy_LexinServiceParserSwedish: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func parseHtml<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubThrowingFunction<(String), [LexinServiceResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParserSwedish.self, method: "parseHtml(text: String) throws -> [LexinServiceResultItem]", parameterMatchers: matchers))
	    }
	    
	    func getUrl() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParserSwedish.self, method: "getUrl() -> String", parameterMatchers: matchers))
	    }
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, parameters: M2) -> Cuckoo.ClassStubFunction<(String, String), (String?, [String: String]?)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParserSwedish.self, method: "getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinServiceParserSwedish: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func parseHtml<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinServiceResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parseHtml(text: String) throws -> [LexinServiceResultItem]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getUrl() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getUrl() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, parameters: M2) -> Cuckoo.__DoNotUse<(String, String), (String?, [String: String]?)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinServiceParserSwedishStub: LexinServiceParserSwedish {
    

    

    
     override func parseHtml(text: String) throws -> [LexinServiceResultItem]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinServiceResultItem]).self)
    }
    
     override func getUrl() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     override func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)  {
        return DefaultValueRegistry.defaultValue(for: ((String?, [String: String]?)).self)
    }
    
}



 class MockLexinServiceParserFolkets: LexinServiceParserFolkets, Cuckoo.ClassMock {
    
     typealias MocksType = LexinServiceParserFolkets
    
     typealias Stubbing = __StubbingProxy_LexinServiceParserFolkets
     typealias Verification = __VerificationProxy_LexinServiceParserFolkets

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LexinServiceParserFolkets?

     func enableDefaultImplementation(_ stub: LexinServiceParserFolkets) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func getUrl() -> String {
        
    return cuckoo_manager.call("getUrl() -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getUrl()
                ,
            defaultCall: __defaultImplStub!.getUrl())
        
    }
    
    
    
     override func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?) {
        
    return cuckoo_manager.call("getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)",
            parameters: (word, parameters),
            escapingParameters: (word, parameters),
            superclassCall:
                
                super.getRequestParameters(word: word, parameters: parameters)
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word: word, parameters: parameters))
        
    }
    
    
    
     override func parseHtml(text: String) throws -> [LexinServiceResultItem] {
        
    return try cuckoo_manager.callThrows("parseHtml(text: String) throws -> [LexinServiceResultItem]",
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                super.parseHtml(text: text)
                ,
            defaultCall: __defaultImplStub!.parseHtml(text: text))
        
    }
    

	 struct __StubbingProxy_LexinServiceParserFolkets: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getUrl() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParserFolkets.self, method: "getUrl() -> String", parameterMatchers: matchers))
	    }
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, parameters: M2) -> Cuckoo.ClassStubFunction<(String, String), (String?, [String: String]?)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParserFolkets.self, method: "getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)", parameterMatchers: matchers))
	    }
	    
	    func parseHtml<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubThrowingFunction<(String), [LexinServiceResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParserFolkets.self, method: "parseHtml(text: String) throws -> [LexinServiceResultItem]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LexinServiceParserFolkets: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getUrl() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getUrl() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, parameters: M2) -> Cuckoo.__DoNotUse<(String, String), (String?, [String: String]?)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parseHtml<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinServiceResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parseHtml(text: String) throws -> [LexinServiceResultItem]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinServiceParserFolketsStub: LexinServiceParserFolkets {
    

    

    
     override func getUrl() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     override func getRequestParameters(word: String, parameters: String) -> (String?, [String: String]?)  {
        return DefaultValueRegistry.defaultValue(for: ((String?, [String: String]?)).self)
    }
    
     override func parseHtml(text: String) throws -> [LexinServiceResultItem]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinServiceResultItem]).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/NetworkService.swift at 2019-10-14 15:03:51 +0000

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
    

    

    

    
    
    
     override func getRequest(url: String) -> Observable<Data> {
        
    return cuckoo_manager.call("getRequest(url: String) -> Observable<Data>",
            parameters: (url),
            escapingParameters: (url),
            superclassCall:
                
                super.getRequest(url: url)
                ,
            defaultCall: __defaultImplStub!.getRequest(url: url))
        
    }
    
    
    
     override func postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<Data> {
        
    return cuckoo_manager.call("postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<Data>",
            parameters: (url, parameters),
            escapingParameters: (url, parameters),
            superclassCall:
                
                super.postRequest(url: url, parameters: parameters)
                ,
            defaultCall: __defaultImplStub!.postRequest(url: url, parameters: parameters))
        
    }
    

	 struct __StubbingProxy_NetworkService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getRequest<M1: Cuckoo.Matchable>(url: M1) -> Cuckoo.ClassStubFunction<(String), Observable<Data>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetworkService.self, method: "getRequest(url: String) -> Observable<Data>", parameterMatchers: matchers))
	    }
	    
	    func postRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(url: M1, parameters: M2) -> Cuckoo.ClassStubFunction<(String, (String?, [String: String]?)?), Observable<Data>> where M1.MatchedType == String, M2.OptionalMatchedType == (String?, [String: String]?) {
	        let matchers: [Cuckoo.ParameterMatcher<(String, (String?, [String: String]?)?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetworkService.self, method: "postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<Data>", parameterMatchers: matchers))
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
	    func getRequest<M1: Cuckoo.Matchable>(url: M1) -> Cuckoo.__DoNotUse<(String), Observable<Data>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return cuckoo_manager.verify("getRequest(url: String) -> Observable<Data>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func postRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(url: M1, parameters: M2) -> Cuckoo.__DoNotUse<(String, (String?, [String: String]?)?), Observable<Data>> where M1.MatchedType == String, M2.OptionalMatchedType == (String?, [String: String]?) {
	        let matchers: [Cuckoo.ParameterMatcher<(String, (String?, [String: String]?)?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return cuckoo_manager.verify("postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<Data>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class NetworkServiceStub: NetworkService {
    

    

    
     override func getRequest(url: String) -> Observable<Data>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Data>).self)
    }
    
     override func postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<Data>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Data>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/PlayerService.swift at 2019-10-14 15:03:51 +0000

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
    

    

    

    
    
    
     override func playSound(url: String) -> Observable<PlayerServiceResult> {
        
    return cuckoo_manager.call("playSound(url: String) -> Observable<PlayerServiceResult>",
            parameters: (url),
            escapingParameters: (url),
            superclassCall:
                
                super.playSound(url: url)
                ,
            defaultCall: __defaultImplStub!.playSound(url: url))
        
    }
    

	 struct __StubbingProxy_PlayerService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func playSound<M1: Cuckoo.Matchable>(url: M1) -> Cuckoo.ClassStubFunction<(String), Observable<PlayerServiceResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPlayerService.self, method: "playSound(url: String) -> Observable<PlayerServiceResult>", parameterMatchers: matchers))
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
	    func playSound<M1: Cuckoo.Matchable>(url: M1) -> Cuckoo.__DoNotUse<(String), Observable<PlayerServiceResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return cuckoo_manager.verify("playSound(url: String) -> Observable<PlayerServiceResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class PlayerServiceStub: PlayerService {
    

    

    
     override func playSound(url: String) -> Observable<PlayerServiceResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<PlayerServiceResult>).self)
    }
    
}

