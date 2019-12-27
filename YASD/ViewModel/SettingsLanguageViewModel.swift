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
    private let settings: SettingsLanguageService
    
    struct Input {
        let search: Driver<String>
        let select: Driver<String>
    }
    
    struct Output {
        let languages: Driver<[SettingsLanguageItem]>
    }
    
    init(settings: SettingsLanguageService) {
        self.settings = settings
    }
    
    func transform(from input: Input) -> Output {
        let searched = input.search
//            .startWith("")
            .flatMapLatest { [weak self] language -> Driver<SettingsLanguageItemResult> in
                guard let self = self else { return Driver.just(.success([])) }
                return self.getSettings(with: language)
        }
        let selected = input.select
            .flatMapLatest { [weak self] language -> Driver<SettingsLanguageResult> in
                guard let self = self else { return Driver.just(.success(false)) }
                return self.settings.update(with: language).asDriver { Driver.just(.failure($0)) }
        }
        .withLatestFrom(input.search) { ($0, $1) }
        .flatMap { [weak self] _, language -> Driver<SettingsLanguageItemResult> in
            guard let self = self else { return Driver.just(.success([])) }
            return self.getSettings(with: language)
        }
        
        return Output(languages: Driver.merge(selected, searched).map { $0.handleResult([], nil) })
    }
    
    private func getSettings(with language: String) -> Driver<SettingsLanguageItemResult> {
        return settings.get(with: language).asDriver { Driver.just(.failure($0)) }
    }
}
