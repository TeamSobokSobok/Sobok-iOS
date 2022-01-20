//
//  ShareService.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/19.
//

import Foundation

import Moya

enum ShareService {
    // 공유 - 캘린더
    case getGroupInfomation
    case getFriendCalendar(memberId: Int, date: String)
    case getFriendPillList(memberId: Int, date: String)
    case editFriendUsername(groupId: Int, memberName: String)
}

extension ShareService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getGroupInfomation:
            return URLs.getGroupInfoURL
        case .getFriendCalendar(let memberId, _):
            return URLs.getFriendCalendarURL.replacingOccurrences(of: "{memberId}", with: "\(memberId)")
        case .getFriendPillList(let memberId, _):
            return URLs.getFriendPillListURL.replacingOccurrences(of: "{memberId}", with: "\(memberId)")
            
        case .editFriendUsername(let groupId, _):
            return URLs.editFriendUsernameURL.replacingOccurrences(of: "{groupId}", with: "\(groupId)")
        }
    }

    var method: Moya.Method {
        switch self {
        case .getGroupInfomation, .getFriendCalendar, .getFriendPillList:
            return .get
            
        case .editFriendUsername:
            return .put
        }
    }

    var task: Task {
        switch self {
        case .getGroupInfomation:
            return .requestPlain
        case .getFriendCalendar(_, let date), .getFriendPillList(_, let date):
            return .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
            
        case .editFriendUsername(_, let memberName):
            return .requestParameters(parameters: ["memberName": memberName], encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getGroupInfomation, .getFriendCalendar, .getFriendPillList, .editFriendUsername:
            return APIConstants.headerWithToken
        }
    }
}
