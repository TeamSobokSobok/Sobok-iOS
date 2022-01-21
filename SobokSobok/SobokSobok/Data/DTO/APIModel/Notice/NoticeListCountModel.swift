//
//  NoticeListCountModel.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/21.
//

import Foundation

// MARK: - NoticeInfo
struct NoticeInfo: Codable {
    let pillInfo: [PillInfo]?
    let calendarInfo: [CalendarInfo]?
}

// MARK: - CalendarInfo
struct CalendarInfo: Codable {
    let groupID, userID: Int
    let username: String
    let isOkay, isSend: Bool
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case groupID = "groupId"
        case userID = "userId"
        case username, isOkay, isSend, createdAt, updatedAt
    }
}

// MARK: - PillInfo
struct PillInfo: Codable {
    let senderID, receiverID: Int
    let isOkay: Bool?
    let isSend: Bool
    let createdAt, updatedAt: String
    let senderName: SenderName
    let receiverName: ReceiverName

    enum CodingKeys: String, CodingKey {
        case senderID = "senderId"
        case receiverID = "receiverId"
        case isOkay, isSend, createdAt, updatedAt, senderName, receiverName
    }
}

enum ReceiverName: String, Codable {
    case 복이 = "복이"
}

enum SenderName: String, Codable {
    case 나나 = "나나"
    case 소복 = "소복"
}
