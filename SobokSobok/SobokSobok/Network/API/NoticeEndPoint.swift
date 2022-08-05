//
//  NoticeEndPoint.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/05.
//

import Foundation

enum NoticeEndPoint {
    case getNoticeList
}

extension NoticeEndPoint: EndPoint {
    var method: HttpMethod {
        switch self {
        case .getNoticeList:
            return .GET
        }
    }
    
    var body: Data? {
        switch self {
        case .getNoticeList:
            return nil
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .getNoticeList:
            return "\(baseURL)/notice/list"
        }
    }
}
