//
//  AboutTextRepository.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 20.02.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import RxSwift

typealias AboutTextRepositoryResult = Result<NSAttributedString>

protocol AboutTextRepository {
    func getText() -> Observable<AboutTextRepositoryResult>
}
