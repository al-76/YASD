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
    private let lexinParameters: ParametersStorage
    
    struct Input {
    }
    
    struct Output {
        let selectedLanguage: Driver<String>
    }

    init(lexinParameters: ParametersStorage) {
        self.lexinParameters = lexinParameters
    }
    
    func transform(input: Input) -> Output {
        let languageUpdate = lexinParameters.language.map { $0.name }
        return Output(selectedLanguage: languageUpdate.asDriver(onErrorJustReturn: ""))
    }
}
