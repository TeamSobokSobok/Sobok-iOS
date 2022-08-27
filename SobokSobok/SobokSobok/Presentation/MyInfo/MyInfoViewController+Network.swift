//
//  MyInfoViewController+Network.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/26.
//

extension MyInfoViewController {
    func getUserPillInfoList() {
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
    
    func getUserDetailPillInfoList(pillId: Int) {
        Task {
            do {
                let detailPillList = try await myInfoManager.getUserDetailPillList(for: pillId)
                print(333, detailPillList)
            }
        }
    }
}
