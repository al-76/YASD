//
//  LexinApiProvider.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 16/11/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift

class LexinApiProvider {
    private let defaultApi: LexinApi
    private let api: [String: LexinApi]
    
    init(defaultApi: LexinApi, folketsApi: LexinApi, swedishApi: LexinApi) {
        self.defaultApi = defaultApi
        self.api = ["eng": folketsApi, "swe": swedishApi]
    }
    
    func getApi(by language: Language) -> LexinApi {
        guard let api = api[language.code] else {
            return defaultApi
        }
        return api
    }
}
