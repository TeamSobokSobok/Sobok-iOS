//
//  AddPillSheetViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/04.
//

import Foundation

import RxSwift
import RxCocoa

final class AddPillSheetViewModel: ViewModelType {
    struct Input {
        let requestPillCount: Signal<Void>
    }
    
    struct Output {
        let didLoadPillCount: Driver<Int>
    }
    
    let addPillManager: PillCountServiceable = PillCountManager(apiService: APIManager(), environment: .development)
    
    var disposeBag = DisposeBag()

    func transform(input: Input) -> Output {
        input.requestPillCount
            .emit { [weak self] _ in
                guard let self = self else { return }
                self.getMyPillCount()
            }
            .disposed(by: disposeBag)
    
        return Output(didLoadPillCount: didLoadPillCount.asDriver())
    }
    
    private let didLoadPillCount = BehaviorRelay<Int>(value: 0)   
}

extension AddPillSheetViewModel {
    
    func getMyPillCount() {
        Task {
            do {
                let result = try await addPillManager.getMyPillCount()
                guard let pillCount = result?.pillCount else { return }
                didLoadPillCount.accept(Int(pillCount)!)
            }
        }
    }
    
    func getFriendPillCount() {
        Task {
            do {
                let result = try await addPillManager.getFriendPillCount(for: 24)
                print("getFriendPill", result?.pillCount)
            }
        }
    }
}
