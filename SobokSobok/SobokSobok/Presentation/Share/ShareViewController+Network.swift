//
//  ShareViewController+Network.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/02.
//

extension ShareViewController {
    func getGroupInformation() {
        Task {
            do {
                let members = try await scheduleManager.getGroupInformation()
                if let members = members,
                   !members.isEmpty {
                    self.members = members
                    shareTopView.friends = members
                    scheduleViewController.friendName = members.first?.memberName
                }
            }
        }
    }
}
