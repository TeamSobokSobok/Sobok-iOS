//
//  SearchNicknameModel.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/19.
//

import Foundation

// MARK: - SearchNickname
struct SearchNickname: Codable {
    let data: SearchNicknameResult?
}

// MARK: - SearchNicknameResult
struct SearchNicknameResult: Codable {
    let memberID: Int
    let memberName: String

    enum CodingKeys: String, CodingKey {
        case memberID = "memberId"
        case memberName
    }
}
