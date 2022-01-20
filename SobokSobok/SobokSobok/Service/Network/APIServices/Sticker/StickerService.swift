//
//  StickerService.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/20.
//

import Foundation
import Moya

enum StickerService {
    case checkSticker(scheduleId: Int)
}

extension StickerService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .checkSticker(let scheduleId):
            return URLs.checkStickerURL.replacingOccurrences(of: "{scheduleId}", with: "\(scheduleId)")
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkSticker(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .checkSticker:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .checkSticker:
            return APIConstants.headerWithToken
        }
    }
}
