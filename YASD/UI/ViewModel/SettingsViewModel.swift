//
//  SettingsViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 26/07/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import RxCocoa

class SettingsViewModel: ViewModel {
    private let getLanguage: AnyUseCase<Void, String>
    
    struct Input {
    }
    
    struct Output {
        let selectedLanguage: Driver<String>
    }

    init(getLanguage: AnyUseCase<Void, String>) {
        self.getLanguage = getLanguage
    }
    
    func transform(from input: Input) -> Output {
        return Output(selectedLanguage: getLanguage.execute(with: ())
                        .asDriver(onErrorJustReturn: Language.defaultLanguage.name))
    }
}
