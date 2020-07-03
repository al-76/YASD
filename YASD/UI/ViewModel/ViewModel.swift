//
//  ViewModel.swift
//  YASD
//
//  Created by Vyacheslav Konopkin on 21/05/2019.
//  Copyright © 2019 yac. All rights reserved.
//

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(from input: Input) -> Output;
}
