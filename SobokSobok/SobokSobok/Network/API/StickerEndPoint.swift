//
//  StickerEndPoint.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/03.
//

import Foundation

enum StickerEndPoint {
    case getStickers(scheduleId: Int)
    case postStickers(scheduleId: Int, stickerId: Int)
}

extension StickerEndPoint: EndPoint {
    var method: HttpMethod {
        switch self {
        case .getStickers:
            return .GET
        case .postStickers:
            return .POST
        }
    }
    
    var body: Data? {
        switch self {
        case .getStickers:
            return nil
        case .postStickers:
            return nil
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .getStickers(let scheduleId):
            return "\(baseURL)/sticker/\(scheduleId)"
        case .postStickers(let scheduleId, let stickerId):
            return "\(baseURL)/sticker/\(scheduleId)?stickerId=\(stickerId)"
        }
    }
}
