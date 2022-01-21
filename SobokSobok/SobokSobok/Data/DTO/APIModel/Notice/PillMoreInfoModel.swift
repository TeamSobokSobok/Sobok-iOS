//
//  PillMoreInfoModel.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/21.
//

import Foundation

// MARK: - PillMoreInfo
struct PillMoreInfo: Codable {
    let senderName: String
    let pillData: [PillData]?
}

// MARK: - PillData
struct PillData: Codable {
    let pillID: Int
    let pillName, color, startDate, endDate: String
    let scheduleCycle, scheduleDay: String
    let scheduleSpecific: String?
    let scheduleTime: [String]

    enum CodingKeys: String, CodingKey {
        case pillID = "pillId"
        case pillName, color, startDate, endDate, scheduleCycle, scheduleDay, scheduleSpecific, scheduleTime
    }
}
