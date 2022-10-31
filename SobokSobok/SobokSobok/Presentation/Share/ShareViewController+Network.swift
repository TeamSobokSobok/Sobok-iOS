//
//  ShareViewController+Network.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/02.
//

import Foundation

extension ShareViewController {
    func getGroupInformation() {
        Task {
            do {
                let members = try await scheduleManager.getGroupInformation()
                if let members = members,
                   !members.isEmpty {
                    print("☀️,☀️,☀️,☀️, ", members)
                    UserDefaults.standard.member = members
                    self.members = members
                    self.scheduleViewController.member = members
                    self.scheduleViewController.collectionView.reloadData()
                }
            }
        }
    }
}
