//
//  WithdrawViewController+Network.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/09/21.
//

extension WithdrawalViewController {
    func withdrawSobokSobok(_ reason: String) {
        Task {
            do {
                _ = try await accountWithdrawManager.deleteUserAccount(in: reason)
            }
        }
    }
}
