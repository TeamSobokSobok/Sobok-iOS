//
//  PillCountService.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/17.
//

import Foundation
import Moya

// MARK: - Course Service

enum PillCountService {
    case getMyPillCount
    case getFriendPillCount(userId: Int)
}

extension PillCountService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getMyPillCount:
            return URLs.getMyPillCountURL
        case .getFriendPillCount(let userId):
            return URLs.getFriendPillCountURL.replacingOccurrences(of: "{userId}", with: "\(userId)")
        }
    }
        
    var method: Moya.Method {
        switch self {
        case .getMyPillCount, .getFriendPillCount(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getMyPillCount, .getFriendPillCount(_):
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        
        switch self {
        case .getMyPillCount, .getFriendPillCount(_):
            return [
                "Content-Type": "application/json",
                "accesstoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjIsImVtYWlsIjoiZWRAZ21haWwuY29tIiwibmFtZSI6bnVsbCwiaWRGaXJlYmFzZSI6InVOR2llMWxKWDNTREpTQnFSWHhLZUhqMnJhMzMiLCJpYXQiOjE2NDE4ODYzNjUsImV4cCI6MTY0NDQ3ODM2NSwiaXNzIjoid2Vzb3B0In0.K9xOhsd1G3sHAo89LRbLHaPySX8PeOW3kxvbbYaVeNA"
            ]
        }
    }
}
