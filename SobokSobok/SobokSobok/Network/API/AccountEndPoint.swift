//
//  AccountEndPoint.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/26.
//

import Foundation
// UserPill

enum AccountEndPoint {
    case getUserPillList
}

extension AccountEndPoint: EndPoint {
    var method: HttpMethod {
        switch self {
        case .getUserPillList:
            return .GET
        }
    }
    
    var body: Data? {
        switch self {
        case .getUserPillList:
            return nil
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .getUserPillList:
            return "\(baseURL)/user/pill"
        }
    }
    
    
}
