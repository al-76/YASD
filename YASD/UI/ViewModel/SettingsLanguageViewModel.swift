//
//  SettingsLanguageTableViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 03/07/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import RxSwift
import RxCocoa

class SettingsLanguageViewModel: ViewModel {
    private let getLanguageList: AnyUseCase<String, SettingsLanguageItemResult>
    private let updateLanguage: AnyUseCase<String, Bool>
    
    struct Input {
        let search: Driver<String>
        let select: Driver<String>
    }
    
    struct Output {
        let languages: Driver<SettingsLanguageItemResult>
    }
    
    init(getLanguageList: AnyUseCase<String, SettingsLanguageItemResult>,
         updateLanguage: AnyUseCase<String, Bool>) {
        self.getLanguageList = getLanguageList
        self.updateLanguage = updateLanguage
    }
    
    func transform(from input: Input) -> Output {
        let searched = input.search
            .flatMapLatest { [weak self] language -> Driver<SettingsLanguageItemResult> in
                guard let self = self else { return .just(.success([])) }
                return self.getSettings(with: language)
        }
        let selected = input.select
            .flatMapLatest { [weak self] language -> Driver<Bool> in
                guard let self = self else { return .just(false) }
                return self.updateLanguage.execute(with: language)
                    .asDriver { _ in .just(false) }
        }
        .withLatestFrom(input.search) { ($0, $1) }
        .flatMap { [weak self] _, language -> Driver<SettingsLanguageItemResult> in
            guard let self = self else { return .just(.success([])) }
            return self.getSettings(with: language)
        }
        
        return Output(languages: Driver.merge(selected, searched))
    }
    
    private func getSettings(with language: String) -> Driver<SettingsLanguageItemResult> {
        return getLanguageList.execute(with: language)
            .asDriver { .just(.failure($0)) }
    }
}
