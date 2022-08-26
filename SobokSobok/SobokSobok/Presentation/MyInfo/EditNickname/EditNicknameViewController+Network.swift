//
//  EditNicknameViewController+Network.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/26.
//

extension EditNicknameViewController {
    func editNickname(for nickname: String) {
        Task {
            do {
                _ = try await editNicknameManager.editUserName(for: nickname)
            }
        }
    }
}
