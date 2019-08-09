// MARK: - Mocks generated from file: YASD/Platform/HtmlParser.swift at 2019-08-09 15:29:06 +0000


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


// MARK: - Mocks generated from file: YASD/Platform/Markdown.swift at 2019-08-09 15:29:06 +0000

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


// MARK: - Mocks generated from file: YASD/Platform/Network.swift at 2019-08-09 15:29:06 +0000

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
    

    

    

    
    
    
     override func postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<String> {
        
    return cuckoo_manager.call("postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<String>",
            parameters: (url, parameters),
            escapingParameters: (url, parameters),
            superclassCall:
                
                super.postRequest(url: url, parameters: parameters)
                ,
            defaultCall: __defaultImplStub!.postRequest(url: url, parameters: parameters))
        
    }
    

	 struct __StubbingProxy_Network: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func postRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(url: M1, parameters: M2) -> Cuckoo.ClassStubFunction<(String, (String?, [String: String]?)?), Observable<String>> where M1.MatchedType == String, M2.OptionalMatchedType == (String?, [String: String]?) {
	        let matchers: [Cuckoo.ParameterMatcher<(String, (String?, [String: String]?)?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockNetwork.self, method: "postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<String>", parameterMatchers: matchers))
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
	    func postRequest<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(url: M1, parameters: M2) -> Cuckoo.__DoNotUse<(String, (String?, [String: String]?)?), Observable<String>> where M1.MatchedType == String, M2.OptionalMatchedType == (String?, [String: String]?) {
	        let matchers: [Cuckoo.ParameterMatcher<(String, (String?, [String: String]?)?)>] = [wrap(matchable: url) { $0.0 }, wrap(matchable: parameters) { $0.1 }]
	        return cuckoo_manager.verify("postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<String>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class NetworkStub: Network {
    

    

    
     override func postRequest(url: String, parameters: (String?, [String: String]?)?) -> Observable<String>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<String>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Service/LexinService.swift at 2019-08-09 15:29:06 +0000

//
//  LexinService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 30/04/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import RxCocoa
import RxSwift
import UIKit


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
    

	 struct __StubbingProxy_LexinServiceParameters: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func get() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParameters.self, method: "get() -> String", parameterMatchers: matchers))
	    }
	    
	    func getLanguageCode() -> Cuckoo.ClassStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLexinServiceParameters.self, method: "getLanguageCode() -> String", parameterMatchers: matchers))
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
	    func get() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("get() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getLanguageCode() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getLanguageCode() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LexinServiceParametersStub: LexinServiceParameters {
    

    

    
     override func get() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     override func getLanguageCode() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
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


// MARK: - Mocks generated from file: YASD/Service/LexinServiceFormatter.swift at 2019-08-09 15:29:06 +0000

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

