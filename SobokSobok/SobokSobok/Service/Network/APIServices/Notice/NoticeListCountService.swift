//
//  NoticeListCountService.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/18.
//

import Foundation

import Moya

// MARK: - NoticeListCount Service

enum NoticeListCountService {
    case getNoticeInfo
}

extension NoticeListCountService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getNoticeInfo:
            return URLs.getNoticeListURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNoticeInfo:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getNoticeInfo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getNoticeInfo:
            return [
                "Content-Type": "application/json",
                "accesstoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjYsImVtYWlsIjoidGVzdEBnbWFpbC5jb20iLCJuYW1lIjpudWxsLCJpZEZpcmViYXNlIjoiTnBRVmhYdUg3eVUwUkpVdUV6Zks3NldWckFGMiIsImlhdCI6MTY0MjA5MjkwMiwiZXhwIjoxNjQ0Njg0OTAyLCJpc3MiOiJ3ZXNvcHQifQ.fZ4bodbWJ3AlgD_c0oE5OyAW2WaXDeQHtApZLaZjdGI"
            ]
        }
    }
}
