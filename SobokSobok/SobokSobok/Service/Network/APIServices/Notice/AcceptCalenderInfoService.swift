//
//  AcceptCalenderInfoService.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/21.
//

import Foundation

import Moya

// MARK: - AcceptCalenderInfo Service

enum AcceptCalenderInfoService {
    case putAcceptCalenderInfo(senderGroupId: Int, isOkay: String)
}
                               
extension AcceptCalenderInfoService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .putAcceptCalenderInfo(_, let isOkay):
            return URLs.acceptCalendarURL.replacingOccurrences(of: "{isOkay}", with: "\(isOkay)")
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .putAcceptCalenderInfo:
            return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .putAcceptCalenderInfo(let senderGroupId, _):
            return .requestParameters(parameters: ["senderGroupId": senderGroupId], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .putAcceptCalenderInfo:
            return [
                "Content-Type": "application/json",
                "accesstoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjYsImVtYWlsIjoidGVzdEBnbWFpbC5jb20iLCJuYW1lIjpudWxsLCJpZEZpcmViYXNlIjoiTnBRVmhYdUg3eVUwUkpVdUV6Zks3NldWckFGMiIsImlhdCI6MTY0MjA5MjkwMiwiZXhwIjoxNjQ0Njg0OTAyLCJpc3MiOiJ3ZXNvcHQifQ.fZ4bodbWJ3AlgD_c0oE5OyAW2WaXDeQHtApZLaZjdGI"
            ]
        }
    }
    
    
}
