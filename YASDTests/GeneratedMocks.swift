// MARK: - Mocks generated from file: YASD/Data/FormattedWord.swift at 2021-05-06 13:29:37 +0000

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

// MARK: - Mocks generated from file: YASD/Data/Lexin/LexinWord.swift at 2021-05-06 13:29:37 +0000

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

// MARK: - Mocks generated from file: YASD/Domain/Data/AboutTextRepository.swift at 2021-05-06 13:29:37 +0000

//
//  AboutTextRepository.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 20.02.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import RxSwift


 class MockAboutTextRepository: AboutTextRepository, Cuckoo.ProtocolMock {
    
     typealias MocksType = AboutTextRepository
    
     typealias Stubbing = __StubbingProxy_AboutTextRepository
     typealias Verification = __VerificationProxy_AboutTextRepository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AboutTextRepository?

     func enableDefaultImplementation(_ stub: AboutTextRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getText() -> Observable<NSAttributedString> {
        
    return cuckoo_manager.call("getText() -> Observable<NSAttributedString>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getText())
        
    }
    

	 struct __StubbingProxy_AboutTextRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getText() -> Cuckoo.ProtocolStubFunction<(), Observable<NSAttributedString>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAboutTextRepository.self, method: "getText() -> Observable<NSAttributedString>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AboutTextRepository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getText() -> Cuckoo.__DoNotUse<(), Observable<NSAttributedString>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getText() -> Observable<NSAttributedString>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AboutTextRepositoryStub: AboutTextRepository {
    

    

    
     func getText() -> Observable<NSAttributedString>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<NSAttributedString>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Domain/Data/PlayerManager.swift at 2021-05-06 13:29:37 +0000

//
//  PlayerManagerI.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 03.06.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
import RxSwift


 class MockPlayerManager: PlayerManager, Cuckoo.ProtocolMock {
    
     typealias MocksType = PlayerManager
    
     typealias Stubbing = __StubbingProxy_PlayerManager
     typealias Verification = __VerificationProxy_PlayerManager

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: PlayerManager?

     func enableDefaultImplementation(_ stub: PlayerManager) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func playSound(with url: String) -> Observable<PlayerManagerResult> {
        
    return cuckoo_manager.call("playSound(with: String) -> Observable<PlayerManagerResult>",
            parameters: (url),
            escapingParameters: (url),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playSound(with: url))
        
    }
    

	 struct __StubbingProxy_PlayerManager: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func playSound<M1: Cuckoo.Matchable>(with url: M1) -> Cuckoo.ProtocolStubFunction<(String), Observable<PlayerManagerResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPlayerManager.self, method: "playSound(with: String) -> Observable<PlayerManagerResult>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_PlayerManager: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func playSound<M1: Cuckoo.Matchable>(with url: M1) -> Cuckoo.__DoNotUse<(String), Observable<PlayerManagerResult>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: url) { $0 }]
	        return cuckoo_manager.verify("playSound(with: String) -> Observable<PlayerManagerResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class PlayerManagerStub: PlayerManager {
    

    

    
     func playSound(with url: String) -> Observable<PlayerManagerResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<PlayerManagerResult>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Domain/Platform/ExternalCacheService.swift at 2021-05-06 13:29:37 +0000

//
//  ExternalCacheService.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26.10.2020.
//  Copyright © 2020 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
import RxSwift


 class MockExternalCacheService: ExternalCacheService, Cuckoo.ProtocolMock {
    
     typealias MocksType = ExternalCacheService
    
     typealias Stubbing = __StubbingProxy_ExternalCacheService
     typealias Verification = __VerificationProxy_ExternalCacheService

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ExternalCacheService?

     func enableDefaultImplementation(_ stub: ExternalCacheService) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func index(data: [FormattedWord]) -> Observable<ExternalCacheServiceResult> {
        
    return cuckoo_manager.call("index(data: [FormattedWord]) -> Observable<ExternalCacheServiceResult>",
            parameters: (data),
            escapingParameters: (data),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.index(data: data))
        
    }
    
    
    
     func getTitle(from id: String) -> String {
        
    return cuckoo_manager.call("getTitle(from: String) -> String",
            parameters: (id),
            escapingParameters: (id),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getTitle(from: id))
        
    }
    

	 struct __StubbingProxy_ExternalCacheService: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func index<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.ProtocolStubFunction<([FormattedWord]), Observable<ExternalCacheServiceResult>> where M1.MatchedType == [FormattedWord] {
	        let matchers: [Cuckoo.ParameterMatcher<([FormattedWord])>] = [wrap(matchable: data) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockExternalCacheService.self, method: "index(data: [FormattedWord]) -> Observable<ExternalCacheServiceResult>", parameterMatchers: matchers))
	    }
	    
	    func getTitle<M1: Cuckoo.Matchable>(from id: M1) -> Cuckoo.ProtocolStubFunction<(String), String> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: id) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockExternalCacheService.self, method: "getTitle(from: String) -> String", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ExternalCacheService: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func index<M1: Cuckoo.Matchable>(data: M1) -> Cuckoo.__DoNotUse<([FormattedWord]), Observable<ExternalCacheServiceResult>> where M1.MatchedType == [FormattedWord] {
	        let matchers: [Cuckoo.ParameterMatcher<([FormattedWord])>] = [wrap(matchable: data) { $0 }]
	        return cuckoo_manager.verify("index(data: [FormattedWord]) -> Observable<ExternalCacheServiceResult>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getTitle<M1: Cuckoo.Matchable>(from id: M1) -> Cuckoo.__DoNotUse<(String), String> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: id) { $0 }]
	        return cuckoo_manager.verify("getTitle(from: String) -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ExternalCacheServiceStub: ExternalCacheService {
    

    

    
     func index(data: [FormattedWord]) -> Observable<ExternalCacheServiceResult>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<ExternalCacheServiceResult>).self)
    }
    
     func getTitle(from id: String) -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Domain/UseCase/About/GetTextAboutUseCase.swift at 2021-05-06 13:29:37 +0000

//
//  GetTextAboutUseCase.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 23.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Cuckoo
@testable import YASD

import Foundation
import RxSwift


 class MockGetTextAboutUseCase: GetTextAboutUseCase, Cuckoo.ClassMock {
    
     typealias MocksType = GetTextAboutUseCase
    
     typealias Stubbing = __StubbingProxy_GetTextAboutUseCase
     typealias Verification = __VerificationProxy_GetTextAboutUseCase

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: GetTextAboutUseCase?

     func enableDefaultImplementation(_ stub: GetTextAboutUseCase) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func execute(with input: Void) -> Observable<NSAttributedString> {
        
    return cuckoo_manager.call("execute(with: Void) -> Observable<NSAttributedString>",
            parameters: (input),
            escapingParameters: (input),
            superclassCall:
                
                super.execute(with: input)
                ,
            defaultCall: __defaultImplStub!.execute(with: input))
        
    }
    

	 struct __StubbingProxy_GetTextAboutUseCase: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func execute<M1: Cuckoo.Matchable>(with input: M1) -> Cuckoo.ClassStubFunction<(Void), Observable<NSAttributedString>> where M1.MatchedType == Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Void)>] = [wrap(matchable: input) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGetTextAboutUseCase.self, method: "execute(with: Void) -> Observable<NSAttributedString>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GetTextAboutUseCase: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func execute<M1: Cuckoo.Matchable>(with input: M1) -> Cuckoo.__DoNotUse<(Void), Observable<NSAttributedString>> where M1.MatchedType == Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Void)>] = [wrap(matchable: input) { $0 }]
	        return cuckoo_manager.verify("execute(with: Void) -> Observable<NSAttributedString>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GetTextAboutUseCaseStub: GetTextAboutUseCase {
    

    

    
     override func execute(with input: Void) -> Observable<NSAttributedString>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<NSAttributedString>).self)
    }
    
}


// MARK: - Mocks generated from file: YASD/Platform/DataCache.swift at 2021-05-06 13:29:37 +0000

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


// MARK: - Mocks generated from file: YASD/Platform/HtmlParser.swift at 2021-05-06 13:29:37 +0000


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


// MARK: - Mocks generated from file: YASD/Platform/Markdown.swift at 2021-05-06 13:29:37 +0000

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


// MARK: - Mocks generated from file: YASD/Platform/Network.swift at 2021-05-06 13:29:37 +0000

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


// MARK: - Mocks generated from file: YASD/Platform/Player.swift at 2021-05-06 13:29:37 +0000

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

