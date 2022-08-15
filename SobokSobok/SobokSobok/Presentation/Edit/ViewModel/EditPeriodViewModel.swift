//
//  EditViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/12.
//

import Foundation

import RxSwift
import RxCocoa

final class EditPeriodViewModel: ViewModelType {
    
    struct Input {
        let didEverydayButtonTap: Signal<Void>
        let didSpecificDayButtonTap: Signal<Void>
        let didSpecificPeriodButtonTap: Signal<Void>
        let selectPeriodButtonTap: Signal<Void>
    }
    
    struct Output {
        let isEverydaySelected: Driver<Bool>
        let isSpecificDaySelected: Driver<Bool>
        let isSpecificPeriodSelected: Driver<Bool>
        let isPeriodSelected: Driver<Bool>
    }
    
    var disposeBag = DisposeBag()
    
    private let isEverydaySelected = BehaviorRelay<Bool>(value: false)
    private let isSpecificDaySelected = BehaviorRelay<Bool>(value: false)
    private let isSpecificPeriodSelected = BehaviorRelay<Bool>(value: false)
    
    func transform(input: Input) -> Output {
        input.didEverydayButtonTap
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                self.isEverydaySelected.accept(!self.isEverydaySelected.value)
            })
            .disposed(by: disposeBag)
        
        input.didSpecificDayButtonTap
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                self.isSpecificDaySelected.accept(!self.isSpecificDaySelected.value)
            })
            .disposed(by: disposeBag)
        
        input.didSpecificPeriodButtonTap
            .emit(onNext: { [weak self] in
                guard let self = self else { return }
                self.isSpecificPeriodSelected.accept(!self.isSpecificPeriodSelected.value)
            })
            .disposed(by: disposeBag)
        
        isEverydaySelected
            .subscribe(onNext: { [weak self] isSelected in
                if isSelected {
                    self?.isSpecificDaySelected.accept(false)
                    self?.isSpecificPeriodSelected.accept(false)
                }
            })
            .disposed(by: disposeBag)
        
        isSpecificDaySelected
            .subscribe(onNext: { [weak self] isSelected in
                if isSelected {
                    self?.isEverydaySelected.accept(false)
                    self?.isSpecificPeriodSelected.accept(false)
                }
            })
            .disposed(by: disposeBag)
        
        isSpecificPeriodSelected
            .subscribe(onNext: { [weak self] isSelected in
                if isSelected {
                    self?.isEverydaySelected.accept(false)
                    self?.isSpecificDaySelected.accept(false)
                }
            })
            .disposed(by: disposeBag)
        
        return Output(
            isEverydaySelected: isEverydaySelected.asDriver(),
            isSpecificDaySelected: isSpecificDaySelected.asDriver(),
            isSpecificPeriodSelected: isSpecificPeriodSelected.asDriver(),
            isPeriodSelected: isSpecificPeriodSelected.asDriver()
        )
    }
}

