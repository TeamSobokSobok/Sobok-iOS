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
    case putAcceptFriend(body: AcceptFriendBody, senderGroupId: Int)
    case putAcceptPill(body: AcceptPillBody, pillId: Int)
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
        case .putAcceptFriend(let body, _):
            return body.encode()
        case .putAcceptPill(let body, _):
            return body.encode()
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .getNoticeList:
            return "\(baseURL)/notice/list"
        case .getPillDetailInfo(let noticeId, let pillId):
            return "\(baseURL)/notice/list/:\(noticeId)/:\(pillId)"
        case .putAcceptFriend(let senderGroupId):
            return "\(baseURL)/group/{\(senderGroupId)}"
        case .putAcceptPill(let pillId):
            return "\(baseURL)/notice/list/:\(pillId)"
        }
    }
}
