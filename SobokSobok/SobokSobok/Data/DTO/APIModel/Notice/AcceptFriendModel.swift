//
//  AcceptFriendModel.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/07.
//

import Foundation

struct AcceptFriend: Codable {
    let sendGroupId: Int?
    let memberName: String
    let isSend: Bool
    let isOkay: String?
    let updatedAt: String
}
