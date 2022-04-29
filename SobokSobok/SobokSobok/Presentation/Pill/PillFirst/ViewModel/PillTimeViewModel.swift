//
//  PillTimeViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/03.
//

import RxCocoa
import RxSwift

struct PillTimeViewModel {
    
    let disposeBag = DisposeBag()
    let pillTimeList = Observable.of(["오전 8:00", "오후 1:00", "오후 7:00"])
    lazy var exampleString = BehaviorRelay<String>(value: "ㅎㅇㅎㅇ")
}

