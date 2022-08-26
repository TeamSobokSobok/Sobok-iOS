//
//  NoticeEndPoint.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/05.
//

import Foundation

enum NoticeEndPoint {
    case getNoticeList
    case getPillDetailInfo(noticeId: Int, pillId: Int)
    case putAcceptFriend(sendGroupId: Int, isOkay: String)
    case putAcceptPill(pillId: Int, isOkay: String)
}

extension NoticeEndPoint: EndPoint {
    var method: HttpMethod {
        switch self {
        case .getNoticeList:
            return .GET
        case .getPillDetailInfo:
            return .GET
        case .putAcceptFriend:
            return .PUT
        case .putAcceptPill:
            return .PUT
        }
    }
    
    var body: Data? {
        switch self {
        case .getNoticeList:
            return nil
        case .getPillDetailInfo:
            return nil
        case .putAcceptFriend(_, let isOkay):
            let query = ["isOkay": isOkay]
            return query.encode()
        case .putAcceptPill(_, let isOkay):
            let query = ["isOkay": isOkay]
            return query.encode()
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .getNoticeList:
            return "\(baseURL)/notice/list"
        case .getPillDetailInfo(let noticeId, let pillId):
            return "\(baseURL)/notice/list/\(noticeId)/\(pillId)"
        case .putAcceptFriend(let sendGroupId, _):
            return "\(baseURL)/group/\(sendGroupId)"
        case .putAcceptPill(let pillId, _):
            return "\(baseURL)/notice/list/\(pillId)"
        }
    }
}
