//
//  AddPill.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/19.
//

import Foundation

// MARK: - SendPill
struct SendPill: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: AddPillInfo?
}

// MARK: - AddPillInfo
struct AddPillInfo: Codable {
    let senderID: Int
    let senderName: String
    let receiverID: Int
    let receiverName, createdAt: String
    let sendPillInfo: [AddPillInfo]

    enum CodingKeys: String, CodingKey {
        case senderID = "senderId"
        case senderName
        case receiverID = "receiverId"
        case receiverName, createdAt, sendPillInfo
    }
}

// MARK: - SendPillInfo
struct SendPillInfo: Codable {
    let sendPillID, pillID: Int
    let isSend: Bool
    let isOkay: Bool

    enum CodingKeys: String, CodingKey {
        case sendPillID = "sendPillId"
        case pillID = "pillId"
        case isSend, isOkay
    }
}

// MARK: - SendInfo
struct SendInfoPill: Codable {
    let pillList: [PillListData]
}

// MARK: - PillList
struct PillListData: Codable {
    let pillName: String
    let isStop: Bool
    let color, start, end, cycle: String
    let day: String?
    let time: [String]
    let specific: String?
}
