//
//  SendPillViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/07.
//

import Foundation

import RxSwift
import RxCocoa

final class SendPillViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    struct Input {
        let didButtonTapped: Signal<Void>
    }
    
    struct Output {
        let requestSendPill: Signal<SendPill>
    }
    
    func transform(input: Input) -> Output {
        input.didButtonTapped.emit { [weak self] _ in
            self?.postMyPill()
        }.disposed(by: disposeBag)
        
        return Output(requestSendPill: requestSendPill.asSignal())
    }
    
    private let requestSendPill = PublishRelay<SendPill>()
    
    var addCellClosure: (() -> Void)?
    var deleteCellClosure: (() -> Void)?
    var deleteTextClosure: (() -> Void)?
    var pillList: Helper<[String]> = Helper([])
    var pillCount: Helper<Int> = Helper(5)
    var index: Helper<Int> = Helper(0)
    var tag: Helper<Int> = Helper(0)
    var footerViewState: Helper<Bool> = Helper(false)
    var addButtonState: Helper<Bool> = Helper(false)
    
    func addCell() {
        pillList.value.append("")
        footerViewState.value = true
        addButtonState.value = false
        pillCount.value -= 1
    }
    
    func deleteCell(index: Int) {
        pillList.value.remove(at: index)
        pillCount.value += 1
    }
    
    func deleteText(index: Int) {
        pillList.value[index] = ""
    }
    
    func hideFooterView(button: inout Bool) {
        button = pillList.value.count == 5 ? true : false
    }
  
    let sendPillManager: SendPillServiceable = SendPillManager(apiService: APIManager(), environment: .development)
     
    var count: Helper<Int> = Helper(0)
    var isTrue: Helper<Bool> = Helper(false)
    var pillName: Helper<[String]> = Helper([])
    var start = ""
    var end = ""
    var takeInterval = 0
    var day = ""
    var specific = ""
    var time: [String] = []
    var memberId = 0
}


extension SendPillViewModel {
    func postMyPill() {
        Task {
            do {
                let sendPill = SendPill(pillName: pillList.value, start: start, end: end, takeInterval: takeInterval, day: day, specific: specific, time: time)
                
                print(sendPill)
                _ = try await sendPillManager.postMyPill(body: sendPill)
            }
        }
    }
    
    func postFriendPill() {
        Task {
            do {
                let sendPill = SendPill(pillName: pillList.value, start: start, end: end, takeInterval: takeInterval, day: day, specific: specific, time: time)
                _ = try await sendPillManager.postFriendPill(body: sendPill, for: memberId)
            }
        }
    }
}
