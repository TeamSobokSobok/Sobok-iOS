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
                "accesstoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjQsImVtYWlsIjoiYmJkQGdtYWlsLmNvbSIsIm5hbWUiOm51bGwsImlkRmlyZWJhc2UiOiJaNVRBM2VWaFVwZHdCV2hHdEpiOVJsWkZMM3YyIiwiaWF0IjoxNjQxODkzNjc1LCJleHAiOjE2NDQ0ODU2NzUsImlzcyI6Indlc29wdCJ9.Qc20TVDA2ptT8SClPC6TsCeFK8_3wQX0RISunGCX90k"
            ]
        }
    }
}
