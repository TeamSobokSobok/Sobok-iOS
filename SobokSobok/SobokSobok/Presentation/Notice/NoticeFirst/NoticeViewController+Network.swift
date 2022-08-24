//
//  NoticeViewController+Network.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/05.
//

extension NoticeViewController {
    func getNoticeList() {
        Task {
            do {
                let noticeList = try await noticeListManager.getNoticeList()
                if let noticeList = noticeList {
                    self.noticeList = noticeList
                }
            }
        }
    }
    
    func putAcceptFriend(for senderGroupId: Int, status isOkay: String) {
        Task {
            do {
                print(222222, friendInfo?.updatedAt)
                let friendInfo = try await noticeListManager.putAcceptFriend(for: senderGroupId, status: isOkay)
                print("여기는 제대로 담기나...", friendInfo)
                if let friendInfo = friendInfo {
                    self.friendInfo = friendInfo
                }
            }
        }
    }
    
    func putAcceptPill(for pillId: Int, status isOkay: String) {
        Task {
            do {
                _ = try await noticeListManager.putAcceptPill(for: pillId, status: isOkay)
            }
        }
    }
}
