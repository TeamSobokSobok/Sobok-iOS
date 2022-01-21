//
//  NoticeService.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/21.
//

import Foundation

import Moya

// MARK: - AcceptCalenderInfo Service
enum NoticeService {
    case putAcceptCalenderInfo(senderGroupId: Int, isOkay: String)
    case putAcceptPillInfo(senderId: Int, receiverId: Int, createdAt: String, isOkay: String)
    case getNoticeInfo(senderId: Int, receiverId: Int, createdAt: String)
    case getPillMoreInfo(senderId: Int, receiverId: Int, createdAt: String)
    
}

extension NoticeService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }

    var path: String {
        switch self {
        case .putAcceptCalenderInfo(_, let isOkay):
            return URLs.acceptCalendarURL.replacingOccurrences(of: "{isOkay}", with: "\(isOkay)")
        case .putAcceptPillInfo(_, _, _, let isOkay):
            return URLs.acceptPillNoticeURL.replacingOccurrences(of: "{isOkay}", with: "\(isOkay)")
        case .getNoticeInfo:
            return URLs.getNoticeListURL
        case .getPillMoreInfo:
            return URLs.getPillNoticeURL
        }
    }

    var method: Moya.Method {
        switch self {
        case .putAcceptCalenderInfo, .putAcceptPillInfo:
            return .put
        case .getNoticeInfo, .getPillMoreInfo:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .putAcceptCalenderInfo(let senderGroupId, _):
            return .requestParameters(parameters: ["senderGroupId": senderGroupId], encoding: URLEncoding.queryString)
        case .putAcceptPillInfo(let senderId, let receiverId, let createdAt, _):
            return .requestParameters(parameters: ["senderId": senderId, "receiverId": receiverId, "createdAt": createdAt], encoding: URLEncoding.queryString)
        case .getNoticeInfo:
            return .requestPlain
        case .getPillMoreInfo(let senderId, let receiverId, let createdAt):
            return .requestParameters(parameters: ["senderId": senderId, "receiverId": receiverId, "createdAt": createdAt], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        switch self {
        case .putAcceptCalenderInfo, .putAcceptPillInfo, .getNoticeInfo, .getPillMoreInfo:
            return APIConstants.headerWithToken
        }
    }
}
