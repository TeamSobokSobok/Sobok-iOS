//
//  Sticker.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/20.
//

import Foundation

struct Stickers: Codable {
    let likeScheduleId: Int
    let scheduleId: Int
    let stickerImg: String
    let username: String
    let isMySticker: Bool
}

struct Sticker: Codable {
    let id: Int?
    let likeScheduleId: Int?
    let scheduleId: Int
    let senderId: Int?
    let stickerId: Int
    let createdAt: String
    let updatedAt: String
}

struct StickerId: Codable {
    let likeScheduleId: Int
    let stickerId: Int
}
