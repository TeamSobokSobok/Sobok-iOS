//
//  WithdrawViewController+Network.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/09/21.
//

import Foundation

extension WithdrawalViewController {
    func withdrawSobokSobok() {
        Task {
            do {
                let _ = try await accountWithdrawManager.deleteUserAccount()
                reset()
            } catch {
                print("🔥 error")
            }
        }
    }
    
    private func reset() {
        UserDefaultsManager.socialID = ""
        UserDefaultsManager.accessToken = ""
        UserDefaultsManager.userName = ""
        UserDefaultsManager.autoLogin = false
        UserDefaults.standard.removeObject(forKey: UserDefaults.Key.member.rawValue)
    }
}
