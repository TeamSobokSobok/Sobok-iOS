//
//  StickerManager.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/03.
//

import Foundation

protocol StickerServiceable {
    func getStickers(for scheduleId: Int) async throws -> [Stickers]?
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
}
