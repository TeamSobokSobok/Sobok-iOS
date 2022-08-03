//
//  StickerManager.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/03.
//

import Foundation

protocol StickerServiceable {
    func getStickers(for scheduleId: Int) async throws -> [Stickers]?
    func postStickers(for scheduleId: Int, withSticker stickerId: Int) async throws -> Sticker?
    func changeSticker(for likeScheduleId: Int, withSticker stickerId: Int) async throws -> [Sticker]?
}

struct StickerManager: StickerServiceable {
    private let apiService: Requestable
    private let environment: APIEnvironment
    
    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getStickers(for scheduleId: Int) async throws -> [Stickers]? {
        let request = StickerEndPoint
            .getStickers(scheduleId: scheduleId)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func postStickers(for scheduleId: Int, withSticker stickerId: Int) async throws -> Sticker? {
        let request = StickerEndPoint
            .postStickers(scheduleId: scheduleId, stickerId: stickerId)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func changeSticker(for likeScheduleId: Int, withSticker stickerId: Int) async throws -> [Sticker]? {
        let request = StickerEndPoint
            .changeSticker(likeScheduleId: likeScheduleId, stickerId: stickerId)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
