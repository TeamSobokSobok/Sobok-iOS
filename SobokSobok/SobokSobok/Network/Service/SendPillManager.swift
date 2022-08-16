//
//  SendPillManager.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/07.
//

import Foundation

protocol SendPillServiceable {
    func postMyPill(body: SendPill) async throws -> SendPill?
    func postFriendPill(body: SendPill, for memberId: Int) async throws -> SendPill?
}

struct SendPillManager: SendPillServiceable {
    private let apiService: Requestable
    private let environment: APIEnvironment
    
    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func postMyPill(body: SendPill) async throws -> SendPill? {
        let request = SendPillEndPoint
            .postMyPill(body: body)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func postFriendPill(body: SendPill, for memberId: Int) async throws -> SendPill? {
        let request = SendPillEndPoint
            .postFriendPill(body: body, memberId: memberId)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
