//
//  PillTimeViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/03.
//

import RxCocoa
import RxSwift

final class PillTimeViewModel: ViewModelType {
    // 추후 추가 예정 !!!!
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    let disposeBag = DisposeBag()
    let pillTimeList = Observable.of(["오전 8:00", "오후 1:00", "오후 7:00"])
    lazy var prelay = BehaviorRelay<String>(value: "ㅎㅇㅎㅇ")
    
    let cellData: Driver<[Time]>
    let pop: Signal<Void>
    let itemSelected = PublishRelay<Int>()
    
    let selectedCategory = PublishSubject<Time>()
    
    
}

