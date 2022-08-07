//
//  PillInfoViewController+Network.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/06.
//

extension PillInfoViewController {
    func getPillDetailInfo(pillId: Int) {
        Task {
            do {
                let pillDetailInfo = try await pillInfoManager.getPillDetailInfo(for: pillId)
                if let pillDetailInfo = pillDetailInfo {
                    self.pillInfoList = pillDetailInfo
                }
            }
        }
    }
    
    func putAcceptPill(pillId: Int) {
        Task {
            do {
                let _ = try await pillInfoManager.putAcceptPill(for: pillId)
            }
        }
    }
}
