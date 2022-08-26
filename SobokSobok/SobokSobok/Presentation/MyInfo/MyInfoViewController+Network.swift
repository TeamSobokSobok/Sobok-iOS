//
//  MyInfoViewController+Network.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/26.
//

extension MyInfoViewController {
    func getUserPillInfoLiost() {
        Task {
            do {
                let userPillList = try await myInfoManager.getUserPillList()
                if let userPillList = userPillList,
                   !userPillList.isEmpty {
                    self.userPillList = userPillList
                }
            }
        }
    }
}
