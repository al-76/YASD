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
    let markdown: Markdown
    
    init(markdown: Markdown) {
        self.markdown = markdown
    }
    
    func getText() -> Observable<NSAttributedString> {
        return Observable.create { [weak self] observer in
            if let self = self {
                observer.onNext(self.markdown
                                    .parse(data: NSLocalizedString("textAbout", comment: "")))
            } else {
                observer.onNext(NSAttributedString())
            }
            observer.onCompleted()
            return Disposables.create {}
        }
    }
}
