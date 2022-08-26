//
//  EditFriendNicknameModel.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/26.
//

import Foundation

struct EditFriendNickname: Codable {
    let groupId: Int
    let userId: Int
    let memberId: Int
    let memberName: String
}
