//
//  SearchNicknameService.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/19.
//

import Foundation
import Moya

enum AddAccountService {
    case searchNickname(username: String)
}

extension AddAccountService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .searchNickname(let username):
            return URLs.getFriendsURL + "?username=\(username)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .searchNickname(_):
            return .get
        }
    }
    
    var sampleData: Data {
            return Data()
    }
    
    var task: Task {
        switch self {
        case .searchNickname:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .searchNickname:
            return [
                "Content-Type": "application/json",
                "accesstoken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjIsImVtYWlsIjoiZWRAZ21haWwuY29tIiwibmFtZSI6bnVsbCwiaWRGaXJlYmFzZSI6InVOR2llMWxKWDNTREpTQnFSWHhLZUhqMnJhMzMiLCJpYXQiOjE2NDE4ODYzNjUsImV4cCI6MTY0NDQ3ODM2NSwiaXNzIjoid2Vzb3B0In0.K9xOhsd1G3sHAo89LRbLHaPySX8PeOW3kxvbbYaVeNA"
            ]
        }
    }
}
