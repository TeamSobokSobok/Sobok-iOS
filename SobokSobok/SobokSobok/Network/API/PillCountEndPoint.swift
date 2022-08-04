//
//  AddPillEndPoint.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/03.
//

import Foundation

enum PillCountEndPoint {
    case getMyPillCount
    case getFriendPillCount(userId: Int)
}

extension PillCountEndPoint: EndPoint {
    var method: HttpMethod {
        switch self {
        case .getMyPillCount:
            return .GET
        case .getFriendPillCount:
            return .GET
        }
    }
    
    var body: Data? {
        switch self {
        case .getMyPillCount:
            return nil
        case .getFriendPillCount:
            return nil
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .getMyPillCount:
            return "\(baseURL)/pill/count"
        case .getFriendPillCount(let userId):
            return "\(baseURL)/pill/\(userId)/count"
        }
    }
}
