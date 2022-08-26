//
//  EditFriendNameViewController+Network.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/26.
//

extension EditFriendNameViewController {
    func editFriendNickname(at groupId: Int, for memberName: String) {
        Task {
            do {
                _ = try await editFriendNameManager.friendNicknameEdit(groupId: groupId, memberName: memberName)
            }
        }
    }
}
