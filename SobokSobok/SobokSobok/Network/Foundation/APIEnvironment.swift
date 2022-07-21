//
//  APIEnvironment.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/30.
//

import Foundation

enum APIEnvironment: String {
    case mock
    case development
    case production
}

extension APIEnvironment {
    var baseURL: String {
        switch self {
        case .mock:
            return "https://fd0fa608-9c5f-4cd0-9046-d1094434bab2.mock.pstmn.io"
        case .development:
            return "https://asia-northeast3-sobok-76d0a.cloudfunctions.net/api"
        case .production:
            return ""
        }
    }
    
    var token: String {
        return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIwLCJlbWFpbCI6Im1hY0BnbWFpbC5jb20iLCJuYW1lIjpudWxsLCJpZEZpcmViYXNlIjoieWVIYWhmTmI2Y1FiUmd4R2Z6a2hhQ3BhNUtmMSIsImlhdCI6MTY1NjA1MjEwMywiZXhwIjoxNjU4NjQ0MTAzLCJpc3MiOiJzb2JvayJ9.4FiXVShdrmy6Dq0pDJEiIyoj3mcAB_zWcm8aivAXVHQ"
    }
}
