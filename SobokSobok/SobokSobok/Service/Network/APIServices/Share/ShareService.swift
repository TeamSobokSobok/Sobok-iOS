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
        }
    }

    var method: Moya.Method {
        switch self {
        case .getGroupInfomation, .getFriendCalendar, .getFriendPillList:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getGroupInfomation:
            return .requestPlain
        case .getFriendCalendar(_, let date), .getFriendPillList(_, let date):
            return .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getGroupInfomation, .getFriendCalendar, .getFriendPillList:
            return APIConstants.headerWithToken
        }
    }
}
