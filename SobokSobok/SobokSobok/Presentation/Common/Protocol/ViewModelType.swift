//
//  ViewModelType.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/04.
//

import Foundation

import RxSwift

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    var disposeBag: DisposeBag { get set }

    func transform(input: Input) -> Output
}
