//
//  Network.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 03.07.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

typealias NetworkResult = Result<Data>

protocol Network {
    typealias Parameters = (String?, [String: String]?)?
    typealias PostParameters = (url: String, parameters: Parameters)

    func postRequest(with parameters: PostParameters) -> Observable<NetworkResult>
    func getRequest(with url: String) -> Observable<NetworkResult>
}
