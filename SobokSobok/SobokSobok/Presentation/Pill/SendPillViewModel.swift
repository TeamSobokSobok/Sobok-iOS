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
    
    let sendPillManager: SendPillServiceable = SendPillManager(apiService: APIManager(), environment: .development)
    
    var pillName: [String] = []
    var start = ""
    var end = ""
    var takeInterval = 0
    var day = ""
    var specific = ""
    var time: [String] = []
    var memberID = 0
}

extension SendPillViewModel {
    func postMyPill() {
        Task {
            do {
                let sendPill = SendPill(pillName: pillName, start: start, end: end, takeInterval: takeInterval, day: day, specific: specific, time: time)
                _ = try await sendPillManager.postMyPill(body: sendPill)
            }
        }
    }
    
    func postFriendPill() {
        Task {
            do {
                let sendPill = SendPill(pillName: pillName, start: start, end: end, takeInterval: takeInterval, day: day, specific: specific, time: time)
                _ = try await sendPillManager.postFriendPill(body: sendPill, for: 187)
            }
        }

    }
}