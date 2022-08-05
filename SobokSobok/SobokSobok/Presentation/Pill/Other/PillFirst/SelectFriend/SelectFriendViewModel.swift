//
//  SendPillFirstViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/05.
//

import Foundation

import RxSwift
import RxCocoa

final class SelectFriendViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    struct Input {
        let requestMemberList: Signal<Void>
    }
    
    struct Output {
        let didLoadMemberList: Driver<[String]>
    }
    
    func transform(input: Input) -> Output {
        input.requestMemberList
            .emit { [weak self] _ in
                guard let self = self else { return }
                self.getGroupInformation()
            }
            .disposed(by: disposeBag)
    
        return Output(didLoadMemberList: didLoadMemberList.asDriver())
        
    }
    
    private let didLoadMemberList = BehaviorRelay<[String]>(value: [])
    var memberName: [String] = []
    private let scheduleManager: ScheduleServiceable = ScheduleManager(apiService: APIManager(), environment: .development)
    
}

extension SelectFriendViewModel {
    func getGroupInformation() {
        Task {
            do {
                let members = try await scheduleManager.getGroupInformation()
                
                guard let members = members else {
                    return
                }
                
                members.forEach {
                    memberName.append($0.memberName)
                    didLoadMemberList.accept(memberName)
                }
                
                }
                

//                if let members = members,
//                   !members.isEmpty {
//                    self.members = members
//                    shareTopView.friends = members
//                }
            }
        }
    }




