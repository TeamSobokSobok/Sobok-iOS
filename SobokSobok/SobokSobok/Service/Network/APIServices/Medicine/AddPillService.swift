//
//  AddPillService.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/19.
//

import Foundation
import Moya

enum AddPillService {
    case addMyPill(body: PillLists)
    case addFriendPill(memberId: Int, body: PillLists)
}

extension AddPillService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .addMyPill:
            return URLs.addMyPillURL
        case .addFriendPill(let memberId, _):
            return URLs.addFriendPillURL.replacingOccurrences(of: "{memberId}", with: "\(memberId)")
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addMyPill, .addFriendPill:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .addMyPill(let body):
            return .requestJSONEncodable(body)

        case .addFriendPill(let memberId, let body):
            return .requestCompositeParameters(bodyParameters: ["pillId" : body.pillList ?? ""], bodyEncoding: JSONEncoding.default, urlParameters: ["memberId" : memberId])
        }
    }
   
    
    var headers: [String: String]? {
            return [
                "Content-Type": "application/json",
                "accesstoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjIsImVtYWlsIjoiZWRAZ21haWwuY29tIiwibmFtZSI6bnVsbCwiaWRGaXJlYmFzZSI6InVOR2llMWxKWDNTREpTQnFSWHhLZUhqMnJhMzMiLCJpYXQiOjE2NDE4ODYzNjUsImV4cCI6MTY0NDQ3ODM2NSwiaXNzIjoid2Vzb3B0In0.K9xOhsd1G3sHAo89LRbLHaPySX8PeOW3kxvbbYaVeNA"
            ]
        }
}
