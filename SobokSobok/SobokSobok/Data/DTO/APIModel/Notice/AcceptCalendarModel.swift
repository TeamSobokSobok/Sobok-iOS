//
//  AcceptCalendarModel.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/21.
//

import Foundation

// MARK: - AcceptCalenderInfo
struct AcceptCalenderInfo: Codable {
    let sendGroupID, senderID: Int
    let senderName: String
    let memberID: Int
    let memberName: String
    let isSend, isOkay: Bool
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case sendGroupID
        case senderID
        case senderName
        case memberID
        case memberName, isSend, isOkay, updatedAt
    }
}
