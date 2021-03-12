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
    private let lexinParameters: LanguageStorage
    
    struct Input {
    }
    
    struct Output {
        let selectedLanguage: Driver<String>
    }

    init(lexinParameters: LanguageStorage) {
        self.lexinParameters = lexinParameters
    }
    
    func transform(from input: Input) -> Output {
        let languageUpdate = lexinParameters.language.map { $0.name }
        return Output(selectedLanguage: languageUpdate.asDriver(onErrorJustReturn: ""))
    }
}
