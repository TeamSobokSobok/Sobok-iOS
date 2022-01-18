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
    let color: Bool
    let stickerImg: [String]?
}
