// MARK: - Mocks generated from file: YASD/Platform/DataCache.swift at 2019-11-22 16:07:52 +0000

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


// MARK: - Mocks generated from file: YASD/Platform/Files.swift at 2019-11-22 16:07:52 +0000

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


// MARK: - Mocks generated from file: YASD/Platform/HtmlParser.swift at 2019-11-22 16:07:52 +0000


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


// MARK: - Mocks generated from file: YASD/Platform/Markdown.swift at 2019-11-22 16:07:52 +0000

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


// MARK: - Mocks generated from file: YASD/Platform/Network.swift at 2019-11-22 16:07:52 +0000

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
    

    

    

    
    
    
     override func postRequest(with: PostParameters) -> Observable<Data> {
        
    return cuckoo_manager.call("postRequest(with: PostParameters) -> Observable<Data>",
            parameters: (with),
            escapingParameters: (with),
            superclassCall:
                
                super.postRequest(with: with)
                ,
            defaultCall: __defaultImplStub!.postRequest(with: with))
        
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
	    
	    
	    func postRequest<M1: Cuckoo.Matchable>(with: M1) -> Cuckoo.ClassStubFunction<(PostParameters), Observable<Data>> where M1.MatchedType == PostParameters {
	        let matchers: [Cuckoo.ParameterMatcher<(PostParameters)>] = [wrap(matchable: with) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetwork.self, method: "postRequest(with: PostParameters) -> Observable<Data>", parameterMatchers: matchers))
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
	    func postRequest<M1: Cuckoo.Matchable>(with: M1) -> Cuckoo.__DoNotUse<(PostParameters), Observable<Data>> where M1.MatchedType == PostParameters {
	        let matchers: [Cuckoo.ParameterMatcher<(PostParameters)>] = [wrap(matchable: with) { $0 }]
	        return cuckoo_manager.verify("postRequest(with: PostParameters) -> Observable<Data>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRequest<M1: Cuckoo.Matchable>(url: M1) -> Cuckoo.__DoNotUse<(String), Observable<Data>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return cuckoo_manager.verify("getRequest(url: String) -> Observable<Data>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class NetworkStub: Network {
    

    

    
     override func postRequest(with: PostParameters) -> Observable<Data>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Data>).self)
    }
    
     override func getRequest(url: String) -> Observable<Data>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Data>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Platform/Player.swift at 2019-11-22 16:07:52 +0000

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


// MARK: - Mocks generated from file: YASD/Platform/Storage.swift at 2019-11-22 16:07:52 +0000

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


// MARK: - Mocks generated from file: YASD/Service/CacheService.swift at 2019-11-22 16:07:52 +0000

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


// MARK: - Mocks generated from file: YASD/Service/LexinApi/LexinApi.swift at 2019-11-22 16:07:52 +0000

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
    

    

    

    
    
    
     override func search(word: String, language: String) -> Observable<LexinParserWordsResult> {
        
    return cuckoo_manager.call("search(word: String, language: String) -> Observable<LexinParserWordsResult>",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.search(word: word, language: language)
                ,
            defaultCall: __defaultImplStub!.search(word: word, language: language))
        
    }
    
    
    
     override func suggestion(word: String, language: String) -> Observable<LexinParserSuggestionResult> {
        
    return cuckoo_manager.call("suggestion(word: String, language: String) -> Observable<LexinParserSuggestionResult>",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.suggestion(word: word, language: language)
                ,
            defaultCall: __defaultImplStub!.suggestion(word: word, language: language))
        
    }
    

	 struct __StubbingProxy_LexinApi: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func search<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.ClassStubFunction<(String, String), Observable<LexinParserWordsResult>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinApi.self, method: "search(word: String, language: String) -> Observable<LexinParserWordsResult>", parameterMatchers: matchers))
	    }
	    
	    func suggestion<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.ClassStubFunction<(String, String), Observable<LexinParserSuggestionResult>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinApi.self, method: "suggestion(word: String, language: String) -> Observable<LexinParserSuggestionResult>", parameterMatchers: matchers))
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
	    func search<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.__DoNotUse<(String, String), Observable<LexinParserWordsResult>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("search(word: String, language: String) -> Observable<LexinParserWordsResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func suggestion<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.__DoNotUse<(String, String), Observable<LexinParserSuggestionResult>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("suggestion(word: String, language: String) -> Observable<LexinParserSuggestionResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinApiStub: LexinApi {
    

    

    
     override func search(word: String, language: String) -> Observable<LexinParserWordsResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<LexinParserWordsResult>).self)
    }
    
     override func suggestion(word: String, language: String) -> Observable<LexinParserSuggestionResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<LexinParserSuggestionResult>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/LexinApi/LexinApiProvider.swift at 2019-11-22 16:07:52 +0000

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
    

    

    

    
    
    
     override func getApi(language: LexinServiceParameters.Language) -> LexinApi {
        
    return cuckoo_manager.call("getApi(language: LexinServiceParameters.Language) -> LexinApi",
            parameters: (language),
            escapingParameters: (language),
            superclassCall:
                
                super.getApi(language: language)
                ,
            defaultCall: __defaultImplStub!.getApi(language: language))
        
    }
    

	 struct __StubbingProxy_LexinApiProvider: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getApi<M1: Cuckoo.Matchable>(language: M1) -> Cuckoo.ClassStubFunction<(LexinServiceParameters.Language), LexinApi> where M1.MatchedType == LexinServiceParameters.Language {
	        let matchers: [Cuckoo.ParameterMatcher<(LexinServiceParameters.Language)>] = [wrap(matchable: language) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinApiProvider.self, method: "getApi(language: LexinServiceParameters.Language) -> LexinApi", parameterMatchers: matchers))
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
	    func getApi<M1: Cuckoo.Matchable>(language: M1) -> Cuckoo.__DoNotUse<(LexinServiceParameters.Language), LexinApi> where M1.MatchedType == LexinServiceParameters.Language {
	        let matchers: [Cuckoo.ParameterMatcher<(LexinServiceParameters.Language)>] = [wrap(matchable: language) { $0 }]
	        return cuckoo_manager.verify("getApi(language: LexinServiceParameters.Language) -> LexinApi", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinApiProviderStub: LexinApiProvider {
    

    

    
     override func getApi(language: LexinServiceParameters.Language) -> LexinApi  {
        return DefaultValueRegistry.defaultValue(for: (LexinApi).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/LexinParser/LexinParserSuggestion.swift at 2019-11-22 16:07:52 +0000

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
    

    

    

    
    
    
     func getRequestParameters(word: String, language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(word: String, language: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word: word, language: language))
        
    }
    
    
    
     func parse(text: String) throws -> [LexinParserSuggestionResultItem] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [LexinParserSuggestionResultItem]",
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
	    
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.ProtocolStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserSuggestion.self, method: "getRequestParameters(word: String, language: String) -> Network.PostParameters", parameterMatchers: matchers))
	    }
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), [LexinParserSuggestionResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserSuggestion.self, method: "parse(text: String) throws -> [LexinParserSuggestionResultItem]", parameterMatchers: matchers))
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
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(word: String, language: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinParserSuggestionResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [LexinParserSuggestionResultItem]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserSuggestionStub: LexinParserSuggestion {
    

    

    
     func getRequestParameters(word: String, language: String) -> Network.PostParameters  {
        return DefaultValueRegistry.defaultValue(for: (Network.PostParameters).self)
    }
    
     func parse(text: String) throws -> [LexinParserSuggestionResultItem]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinParserSuggestionResultItem]).self)
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
    

    

    

    
    
    
     override func getRequestParameters(word: String, language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(word: String, language: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.getRequestParameters(word: word, language: language)
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word: word, language: language))
        
    }
    
    
    
     override func parse(text: String) throws -> [LexinParserSuggestionResultItem] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [LexinParserSuggestionResultItem]",
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
	    
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.ClassStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserSuggestionDefault.self, method: "getRequestParameters(word: String, language: String) -> Network.PostParameters", parameterMatchers: matchers))
	    }
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubThrowingFunction<(String), [LexinParserSuggestionResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserSuggestionDefault.self, method: "parse(text: String) throws -> [LexinParserSuggestionResultItem]", parameterMatchers: matchers))
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
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(word: String, language: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinParserSuggestionResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [LexinParserSuggestionResultItem]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserSuggestionDefaultStub: LexinParserSuggestionDefault {
    

    

    
     override func getRequestParameters(word: String, language: String) -> Network.PostParameters  {
        return DefaultValueRegistry.defaultValue(for: (Network.PostParameters).self)
    }
    
     override func parse(text: String) throws -> [LexinParserSuggestionResultItem]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinParserSuggestionResultItem]).self)
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
    

    

    

    
    
    
     override func getRequestParameters(word: String, language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(word: String, language: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.getRequestParameters(word: word, language: language)
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word: word, language: language))
        
    }
    
    
    
     override func parse(text: String) throws -> [LexinParserSuggestionResultItem] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [LexinParserSuggestionResultItem]",
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
	    
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.ClassStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserSuggestionFolkets.self, method: "getRequestParameters(word: String, language: String) -> Network.PostParameters", parameterMatchers: matchers))
	    }
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubThrowingFunction<(String), [LexinParserSuggestionResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserSuggestionFolkets.self, method: "parse(text: String) throws -> [LexinParserSuggestionResultItem]", parameterMatchers: matchers))
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
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(word: String, language: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinParserSuggestionResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [LexinParserSuggestionResultItem]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserSuggestionFolketsStub: LexinParserSuggestionFolkets {
    

    

    
     override func getRequestParameters(word: String, language: String) -> Network.PostParameters  {
        return DefaultValueRegistry.defaultValue(for: (Network.PostParameters).self)
    }
    
     override func parse(text: String) throws -> [LexinParserSuggestionResultItem]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinParserSuggestionResultItem]).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/LexinParser/LexinParserWords.swift at 2019-11-22 16:07:52 +0000

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
    

    

    

    
    
    
     func getRequestParameters(word: String, language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(word: String, language: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word: word, language: language))
        
    }
    
    
    
     func parse(text: String) throws -> [LexinParserWordsResultItem] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [LexinParserWordsResultItem]",
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
	    
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.ProtocolStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWords.self, method: "getRequestParameters(word: String, language: String) -> Network.PostParameters", parameterMatchers: matchers))
	    }
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ProtocolStubThrowingFunction<(String), [LexinParserWordsResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWords.self, method: "parse(text: String) throws -> [LexinParserWordsResultItem]", parameterMatchers: matchers))
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
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(word: String, language: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinParserWordsResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [LexinParserWordsResultItem]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserWordsStub: LexinParserWords {
    

    

    
     func getRequestParameters(word: String, language: String) -> Network.PostParameters  {
        return DefaultValueRegistry.defaultValue(for: (Network.PostParameters).self)
    }
    
     func parse(text: String) throws -> [LexinParserWordsResultItem]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinParserWordsResultItem]).self)
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
    

    

    

    
    
    
     override func getRequestParameters(word: String, language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(word: String, language: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.getRequestParameters(word: word, language: language)
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word: word, language: language))
        
    }
    
    
    
     override func parse(text: String) throws -> [LexinParserWordsResultItem] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [LexinParserWordsResultItem]",
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
	    
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.ClassStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWordsDefault.self, method: "getRequestParameters(word: String, language: String) -> Network.PostParameters", parameterMatchers: matchers))
	    }
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubThrowingFunction<(String), [LexinParserWordsResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWordsDefault.self, method: "parse(text: String) throws -> [LexinParserWordsResultItem]", parameterMatchers: matchers))
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
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(word: String, language: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinParserWordsResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [LexinParserWordsResultItem]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserWordsDefaultStub: LexinParserWordsDefault {
    

    

    
     override func getRequestParameters(word: String, language: String) -> Network.PostParameters  {
        return DefaultValueRegistry.defaultValue(for: (Network.PostParameters).self)
    }
    
     override func parse(text: String) throws -> [LexinParserWordsResultItem]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinParserWordsResultItem]).self)
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
    

    

    

    
    
    
     override func parse(text: String) throws -> [LexinParserWordsResultItem] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [LexinParserWordsResultItem]",
            parameters: (text),
            escapingParameters: (text),
            superclassCall:
                
                super.parse(text: text)
                ,
            defaultCall: __defaultImplStub!.parse(text: text))
        
    }
    
    
    
     override func getRequestParameters(word: String, language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(word: String, language: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.getRequestParameters(word: word, language: language)
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word: word, language: language))
        
    }
    

	 struct __StubbingProxy_LexinParserWordsSwedish: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubThrowingFunction<(String), [LexinParserWordsResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWordsSwedish.self, method: "parse(text: String) throws -> [LexinParserWordsResultItem]", parameterMatchers: matchers))
	    }
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.ClassStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWordsSwedish.self, method: "getRequestParameters(word: String, language: String) -> Network.PostParameters", parameterMatchers: matchers))
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
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinParserWordsResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [LexinParserWordsResultItem]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(word: String, language: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserWordsSwedishStub: LexinParserWordsSwedish {
    

    

    
     override func parse(text: String) throws -> [LexinParserWordsResultItem]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinParserWordsResultItem]).self)
    }
    
     override func getRequestParameters(word: String, language: String) -> Network.PostParameters  {
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
    

    

    

    
    
    
     override func getRequestParameters(word: String, language: String) -> Network.PostParameters {
        
    return cuckoo_manager.call("getRequestParameters(word: String, language: String) -> Network.PostParameters",
            parameters: (word, language),
            escapingParameters: (word, language),
            superclassCall:
                
                super.getRequestParameters(word: word, language: language)
                ,
            defaultCall: __defaultImplStub!.getRequestParameters(word: word, language: language))
        
    }
    
    
    
     override func parse(text: String) throws -> [LexinParserWordsResultItem] {
        
    return try cuckoo_manager.callThrows("parse(text: String) throws -> [LexinParserWordsResultItem]",
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
	    
	    
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.ClassStubFunction<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWordsFolkets.self, method: "getRequestParameters(word: String, language: String) -> Network.PostParameters", parameterMatchers: matchers))
	    }
	    
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.ClassStubThrowingFunction<(String), [LexinParserWordsResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinParserWordsFolkets.self, method: "parse(text: String) throws -> [LexinParserWordsResultItem]", parameterMatchers: matchers))
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
	    func getRequestParameters<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(word: M1, language: M2) -> Cuckoo.__DoNotUse<(String, String), Network.PostParameters> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: word) { $0.0 }, wrap(matchable: language) { $0.1 }]
	        return cuckoo_manager.verify("getRequestParameters(word: String, language: String) -> Network.PostParameters", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func parse<M1: Cuckoo.Matchable>(text: M1) -> Cuckoo.__DoNotUse<(String), [LexinParserWordsResultItem]> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: text) { $0 }]
	        return cuckoo_manager.verify("parse(text: String) throws -> [LexinParserWordsResultItem]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinParserWordsFolketsStub: LexinParserWordsFolkets {
    

    

    
     override func getRequestParameters(word: String, language: String) -> Network.PostParameters  {
        return DefaultValueRegistry.defaultValue(for: (Network.PostParameters).self)
    }
    
     override func parse(text: String) throws -> [LexinParserWordsResultItem]  {
        return DefaultValueRegistry.defaultValue(for: ([LexinParserWordsResultItem]).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/LexinService/LexinService.swift at 2019-11-22 16:07:52 +0000

//
//  LexinService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
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
	    
	    
	    func getLanguageString() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParameters.self, method: "getLanguageString() -> String", parameterMatchers: matchers))
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
    

    

    
     override func getLanguageString() -> String  {
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
    

    

    

    
    
    
     override func search(word: String) -> Observable<LexinParserWordsResult> {
        
    return cuckoo_manager.call("search(word: String) -> Observable<LexinParserWordsResult>",
            parameters: (word),
            escapingParameters: (word),
            superclassCall:
                
                super.search(word: word)
                ,
            defaultCall: __defaultImplStub!.search(word: word))
        
    }
    
    
    
     override func suggestion(word: String) -> Observable<LexinParserSuggestionResult> {
        
    return cuckoo_manager.call("suggestion(word: String) -> Observable<LexinParserSuggestionResult>",
            parameters: (word),
            escapingParameters: (word),
            superclassCall:
                
                super.suggestion(word: word)
                ,
            defaultCall: __defaultImplStub!.suggestion(word: word))
        
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
    

	 struct __StubbingProxy_LexinService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func search<M1: Cuckoo.Matchable>(word: M1) -> Cuckoo.ClassStubFunction<(String), Observable<LexinParserWordsResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinService.self, method: "search(word: String) -> Observable<LexinParserWordsResult>", parameterMatchers: matchers))
	    }
	    
	    func suggestion<M1: Cuckoo.Matchable>(word: M1) -> Cuckoo.ClassStubFunction<(String), Observable<LexinParserSuggestionResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinService.self, method: "suggestion(word: String) -> Observable<LexinParserSuggestionResult>", parameterMatchers: matchers))
	    }
	    
	    func language() -> Cuckoo.ClassStubFunction<(), BehaviorSubject<LexinServiceParameters.Language>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinService.self, method: "language() -> BehaviorSubject<LexinServiceParameters.Language>", parameterMatchers: matchers))
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
	    func search<M1: Cuckoo.Matchable>(word: M1) -> Cuckoo.__DoNotUse<(String), Observable<LexinParserWordsResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return cuckoo_manager.verify("search(word: String) -> Observable<LexinParserWordsResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func suggestion<M1: Cuckoo.Matchable>(word: M1) -> Cuckoo.__DoNotUse<(String), Observable<LexinParserSuggestionResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: word) { $0 }]
	        return cuckoo_manager.verify("suggestion(word: String) -> Observable<LexinParserSuggestionResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func language() -> Cuckoo.__DoNotUse<(), BehaviorSubject<LexinServiceParameters.Language>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("language() -> BehaviorSubject<LexinServiceParameters.Language>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinServiceStub: LexinService {
    

    

    
     override func search(word: String) -> Observable<LexinParserWordsResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<LexinParserWordsResult>).self)
    }
    
     override func suggestion(word: String) -> Observable<LexinParserSuggestionResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<LexinParserSuggestionResult>).self)
    }
    
     override func language() -> BehaviorSubject<LexinServiceParameters.Language>  {
        return DefaultValueRegistry.defaultValue(for: (BehaviorSubject<LexinServiceParameters.Language>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/LexinService/LexinServiceFormatter.swift at 2019-11-22 16:07:52 +0000

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
    

    

    

    
    
    
     override func format(result: LexinParserWordsResult) -> LexinServiceResultFormatted {
        
    return cuckoo_manager.call("format(result: LexinParserWordsResult) -> LexinServiceResultFormatted",
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
	    
	    
	    func format<M1: Cuckoo.Matchable>(result: M1) -> Cuckoo.ClassStubFunction<(LexinParserWordsResult), LexinServiceResultFormatted> where M1.MatchedType == LexinParserWordsResult {
	        let matchers: [Cuckoo.ParameterMatcher<(LexinParserWordsResult)>] = [wrap(matchable: result) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceFormatter.self, method: "format(result: LexinParserWordsResult) -> LexinServiceResultFormatted", parameterMatchers: matchers))
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
	    func format<M1: Cuckoo.Matchable>(result: M1) -> Cuckoo.__DoNotUse<(LexinParserWordsResult), LexinServiceResultFormatted> where M1.MatchedType == LexinParserWordsResult {
	        let matchers: [Cuckoo.ParameterMatcher<(LexinParserWordsResult)>] = [wrap(matchable: result) { $0 }]
	        return cuckoo_manager.verify("format(result: LexinParserWordsResult) -> LexinServiceResultFormatted", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinServiceFormatterStub: LexinServiceFormatter {
    

    

    
     override func format(result: LexinParserWordsResult) -> LexinServiceResultFormatted  {
        return DefaultValueRegistry.defaultValue(for: (LexinServiceResultFormatted).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/NetworkService.swift at 2019-11-22 16:07:52 +0000

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
    

    

    

    
    
    
     override func getRequest(url: String) -> Observable<String> {
        
    return cuckoo_manager.call("getRequest(url: String) -> Observable<String>",
            parameters: (url),
            escapingParameters: (url),
            superclassCall:
                
                super.getRequest(url: url)
                ,
            defaultCall: __defaultImplStub!.getRequest(url: url))
        
    }
    
    
    
     override func postRequest(with parameters: Network.PostParameters) -> Observable<String> {
        
    return cuckoo_manager.call("postRequest(with: Network.PostParameters) -> Observable<String>",
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
	    
	    
	    func getRequest<M1: Cuckoo.Matchable>(url: M1) -> Cuckoo.ClassStubFunction<(String), Observable<String>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetworkService.self, method: "getRequest(url: String) -> Observable<String>", parameterMatchers: matchers))
	    }
	    
	    func postRequest<M1: Cuckoo.Matchable>(with parameters: M1) -> Cuckoo.ClassStubFunction<(Network.PostParameters), Observable<String>> where M1.MatchedType == Network.PostParameters {
	        let matchers: [Cuckoo.ParameterMatcher<(Network.PostParameters)>] = [wrap(matchable: parameters) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetworkService.self, method: "postRequest(with: Network.PostParameters) -> Observable<String>", parameterMatchers: matchers))
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
	    func getRequest<M1: Cuckoo.Matchable>(url: M1) -> Cuckoo.__DoNotUse<(String), Observable<String>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return cuckoo_manager.verify("getRequest(url: String) -> Observable<String>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func postRequest<M1: Cuckoo.Matchable>(with parameters: M1) -> Cuckoo.__DoNotUse<(Network.PostParameters), Observable<String>> where M1.MatchedType == Network.PostParameters {
	        let matchers: [Cuckoo.ParameterMatcher<(Network.PostParameters)>] = [wrap(matchable: parameters) { $0 }]
	        return cuckoo_manager.verify("postRequest(with: Network.PostParameters) -> Observable<String>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class NetworkServiceStub: NetworkService {
    

    

    
     override func getRequest(url: String) -> Observable<String>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<String>).self)
    }
    
     override func postRequest(with parameters: Network.PostParameters) -> Observable<String>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<String>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/PlayerService.swift at 2019-11-22 16:07:52 +0000

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

