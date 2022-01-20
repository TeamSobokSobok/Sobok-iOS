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
                "accesstoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjQsImVtYWlsIjoiYmJkQGdtYWlsLmNvbSIsIm5hbWUiOm51bGwsImlkRmlyZWJhc2UiOiJaNVRBM2VWaFVwZHdCV2hHdEpiOVJsWkZMM3YyIiwiaWF0IjoxNjQxODkzNjc1LCJleHAiOjE2NDQ0ODU2NzUsImlzcyI6Indlc29wdCJ9.Qc20TVDA2ptT8SClPC6TsCeFK8_3wQX0RISunGCX90k"
            ]
        }
    }
}
