//
//  EditFriendUsername.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/21.
//

import Foundation

// MARK: - EditFriendUsername
struct EditFriendUsername: Codable {
    let groupID, userID, memberID: Int
    let memberName: String

    enum CodingKeys: String, CodingKey {
        case groupID
        case userID
        case memberID
        case memberName
    }
}
