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
    
    func putAcceptFriend(status body: String, at senderGoupId: Int) {
        Task {
            do {
                let status = AcceptFriendBody(isOkay: body)
                let friendInfo = try await noticeListManager.putAcceptFriend(status: status, for: senderGoupId)
                if let friendInfo = friendInfo {
                    self.friendInfo = friendInfo
                }
            }
        }
    }
    
    func putAcceptPill(status body: String, at pillId: Int) {
        Task {
            do {
                let status = AcceptPillBody(isOkay: body)
                _ = try await noticeListManager.putAcceptPill(status: status, for: pillId)
            }
        }
    }
}
