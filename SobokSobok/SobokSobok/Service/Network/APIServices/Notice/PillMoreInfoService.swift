//
//  PillMoreInfoService.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/18.
//

import Foundation

import Moya

// MARK: - PillMoreInfo Service

enum PillMoreInfoService {
    case getPillMoreInfo(senderId: Int, receiverId: Int, createdAt: String)
}

extension PillMoreInfoService: TargetType {
    
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getPillMoreInfo:
            return URLs.getPillNoticeURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPillMoreInfo:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPillMoreInfo(let senderId, let receiverId, let createdAt):
            return .requestParameters(parameters: ["senderId": senderId, "receiverId": receiverId, "createdAt": createdAt], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getPillMoreInfo:
            return [
                "Content-Type": "application/json",
                "accesstoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjQsImVtYWlsIjoiYmJkQGdtYWlsLmNvbSIsIm5hbWUiOm51bGwsImlkRmlyZWJhc2UiOiJaNVRBM2VWaFVwZHdCV2hHdEpiOVJsWkZMM3YyIiwiaWF0IjoxNjQxODkzNjc1LCJleHAiOjE2NDQ0ODU2NzUsImlzcyI6Indlc29wdCJ9.Qc20TVDA2ptT8SClPC6TsCeFK8_3wQX0RISunGCX90k"
            ]
        }
    }
}
