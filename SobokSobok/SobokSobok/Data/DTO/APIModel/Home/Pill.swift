//
//  Pill.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/18.
//

import Foundation

struct PillList: Codable {
    let scheduleTime: String
    let scheduleList: [Pill]?
}

struct Pill: Codable {
    let scheduleId: Int
    let pillId: Int
    let pillName: String
    let scheduleTime: String
    let isCheck: Bool
    let color: String
//    let stickerImg: [String]?
    let stickerId: [StickerId]?
    let stickerTotalCount: Int
}

struct PillDetail: Codable {
    let scheduleId: Int
    let pillId: Int
    let userId: Int
    let scheduleDate: String
    let scheduleTime: String
    let isCheck: Bool
}
