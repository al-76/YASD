//
//  AboutViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 23.04.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import RxSwift
import RxCocoa

class AboutViewModel: ViewModel {
    struct Input {
    }
    
    struct Output {
        let text: Driver<AboutTextRepositoryResult>
    }
    
    private let getText: AnyUseCase<Void, AboutTextRepositoryResult>
    
    init(getText: AnyUseCase<Void, AboutTextRepositoryResult>) {
        self.getText = getText
    }
    
    func transform(from input: Input) -> Output {
        return Output(text: getText.execute(with: ())
                        .asDriver { .just(.failure($0)) })
    }
}
