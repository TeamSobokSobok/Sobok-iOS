//
//  SendPillEndPoint.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/07.
//

import Foundation

enum SendPillEndPoint {
    case postMyPill(body: SendPill)
    case postFriendPill(body: SendPill, memberId: Int)
}

extension SendPillEndPoint: EndPoint {
    var method: HttpMethod {
        switch self {
        case .postMyPill:
            return .POST
        case .postFriendPill:
            return .POST
        }
    }
    
    var body: Data? {
        switch self {
        case .postMyPill(let body):
            return body.encode()
        case .postFriendPill(let body, _):
            return body.encode()
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .postMyPill:
            return "\(baseURL)/pill"
        case .postFriendPill(_, let memberId):
            return "\(baseURL)/pill/member/\(memberId)"
        }
    }
}
    
