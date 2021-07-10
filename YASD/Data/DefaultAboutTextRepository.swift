//
//  DefaultAboutTextRepository.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 20.02.2021.
//  Copyright © 2021 yac. All rights reserved.
//

import Foundation
import RxSwift

class DefaultAboutTextRepository: AboutTextRepository {
    enum DefaultAboutTextRepositoryError: Error {
        case noContext
    }

    let markdown: Markdown

    init(markdown: Markdown) {
        self.markdown = markdown
    }

    func getText() -> Observable<AboutTextRepositoryResult> {
        return Observable.create { [weak self] observer in
            if let self = self {
                let text = self.markdown
                    .parse(data: NSLocalizedString("textAbout", comment: "")
                            .replacingOccurrences(of: "%s", with: self.getAppVersion()))
                observer.onNext(.success(text))
            } else {
                observer.onNext(.failure(DefaultAboutTextRepositoryError.noContext))
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }

    private func getAppVersion() -> String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
        return (version as? String) ?? "1.0.0"
    }
}
