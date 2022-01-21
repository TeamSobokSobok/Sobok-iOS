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

struct PillListData: Codable {
    let pillName: String
    let isStop: Bool
    let color: String
    let start: String
    let end: String
    let cycle: String
    let day: String?
    let time: [String]
    let specific: String?
    
    init (_ pillName: String, _ isStop: Bool, _ color: String, _ start: String, _ end: String, _ cycle: String, _ day: String?, _ time: [String], _ specific: String?) {
        self.pillName = pillName
        self.isStop = isStop
        self.color = color
        self.start = start
        self.end = end
        self.cycle = cycle
        self.day = day
        self.time = time
        self.specific = specific
    }
}

struct PillLists: Codable {
    let pillList: [PillListRequest]?
}

// MARK: - PillList
struct PillListRequest: Codable {
    let pillName: String
    let isStop: Bool
    let color, start, end, cycle: String
    let day: String?
    let time: [String]
    let specific: String?
    
    init (_ pillName: String, _ isStop: Bool, _ color: String, _ start: String, _ end: String, _ cycle: String, _ day: String?, _ time: [String], _ specific: String? = nil) {
        self.pillName = pillName
        self.isStop = isStop
        self.color = color
        self.start = start
        self.end = end
        self.cycle = cycle
        self.day = day
        self.time = time
        self.specific = specific
    }
}
