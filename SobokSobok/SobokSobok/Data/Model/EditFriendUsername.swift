//
//  EditFriendUsername.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/21.
//

import Foundation

// MARK: - EditFriendUsername
struct EditFriendUsername: Codable {
    let groupId: Int
    let userId: Int
    let memberId: Int
    let memberName: String
}
