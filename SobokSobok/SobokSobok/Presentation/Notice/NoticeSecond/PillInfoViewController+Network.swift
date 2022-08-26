//
//  PillInfoViewController+Network.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/06.
//

extension PillInfoViewController {
    func getPillDetailInfo(noticeId: Int, pillId: Int) {
        Task {
            do {
                let pillDetailInfo = try await pillInfoManager.getPillDetailInfo(noticeId: noticeId, pillId: pillId)
                if let pillDetailInfo = pillDetailInfo {
                    self.pillInfoList = pillDetailInfo
                }
            }
        }
    }
}
