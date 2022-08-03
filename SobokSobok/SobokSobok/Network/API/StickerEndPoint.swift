//
//  StickerEndPoint.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/03.
//

import Foundation

enum StickerEndPoint {
    case getStickers(scheduleId: Int)
}

extension StickerEndPoint: EndPoint {
    var method: HttpMethod {
        switch self {
        case .getStickers:
            return .GET
        }
    }
    
    var body: Data? {
        switch self {
        case .getStickers:
            return nil
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .getStickers(let scheduleId):
            return "\(baseURL)/sticker/\(scheduleId)"
        }
    }
}
