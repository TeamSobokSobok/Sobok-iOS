//
//  AddPillService.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/19.
//

import Foundation
import Moya

enum AddPillService {
    case addMyPill(pillName: String, isStop: Bool, color: String, start: String, end: String, cycle: String, day: String, time: [String], specific: String)
    case addFriendPill(memberId: Int, pillName: String, isStop: Bool, color: String, start: String, end: String, cycle: String, day: String, time: [String], specific: String)
}

extension AddPillService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .addMyPill(_, _, _, _, _, _, _, _, _):
            return URLs.addMyPillURL
        case .addFriendPill(let memberId, _, _, _, _, _, _, _, _, _):
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
        case .addMyPill(let pillName, let isStop, let color, let start, let end, let cycle, let day, let time, let specific):
            return .requestParameters(parameters: ["pillName": pillName,
                                                   "isStop": isStop,
                                                   "color": color,
                                                   "start": start,
                                                   "end": end,
                                                   "cycle": cycle,
                                                   "day": day,
                                                   "time": time,
                                                   "specific": specific], encoding: JSONEncoding.default)
        case .addFriendPill(_, let pillName, let isStop, let color, let start, let end, let cycle, let day, let time, let specific):
           return .requestParameters(parameters: ["pillName": pillName,
                                                  "isStop": isStop,
                                                  "color": color,
                                                  "start": start,
                                                  "end": end,
                                                  "cycle": cycle,
                                                  "day": day,
                                                  "time": time,
                                                  "specific": specific], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
            return [
                "Content-Type": "application/json",
                "accesstoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjIsImVtYWlsIjoiZWRAZ21haWwuY29tIiwibmFtZSI6bnVsbCwiaWRGaXJlYmFzZSI6InVOR2llMWxKWDNTREpTQnFSWHhLZUhqMnJhMzMiLCJpYXQiOjE2NDE4ODYzNjUsImV4cCI6MTY0NDQ3ODM2NSwiaXNzIjoid2Vzb3B0In0.K9xOhsd1G3sHAo89LRbLHaPySX8PeOW3kxvbbYaVeNA"
            ]
        }
}

