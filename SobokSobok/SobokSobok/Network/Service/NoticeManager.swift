//
//  NoticeManager.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/05.
//

import Foundation

protocol NoticeServiceable {
    func getNoticeList() async throws -> NoticeList?
    func getPillDetailInfo(noticeId: Int, pillId: Int) async throws -> PillDetailInfo?
    func putAcceptFriend(status body: AcceptFriendBody, for senderGroupId: Int) async throws -> AcceptFriend?
    func putAcceptPill(status body: AcceptPillBody, for pillId: Int) async throws -> AcceptPill?
}

struct NoticeManager: NoticeServiceable {
    private let apiService: Requestable
    private let environment: APIEnvironment
    
    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getNoticeList() async throws -> NoticeList? {
        let request = NoticeEndPoint
            .getNoticeList
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func getPillDetailInfo(noticeId: Int, pillId: Int) async throws -> PillDetailInfo? {
        let request = NoticeEndPoint
            .getPillDetailInfo(noticeId: noticeId, pillId: pillId)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func putAcceptFriend(status body: AcceptFriendBody, for senderGroupId: Int) async throws -> AcceptFriend? {
        let request = NoticeEndPoint
            .putAcceptFriend(body: body, senderGroupId: senderGroupId)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func putAcceptPill(status body: AcceptPillBody, for pillId: Int) async throws -> AcceptPill? {
        let request = NoticeEndPoint
            .putAcceptPill(body: body, pillId: pillId)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
