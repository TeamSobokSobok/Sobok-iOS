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
                "accesstoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoic29ib2tAZ21haWwuY29tIiwibmFtZSI6bnVsbCwiaWRGaXJlYmFzZSI6Im52NzdlS0Z3T1FURU0zTVRvcUlNbW9QQlR6bDEiLCJpYXQiOjE2NDIwOTMxMDcsImV4cCI6MTY0NDY4NTEwNywiaXNzIjoid2Vzb3B0In0.eXLGkqQlrEqlWZCvMdJCtaTRNUCOwg7vT6clQkD6NZ4"
            ]
        }
    }
}
