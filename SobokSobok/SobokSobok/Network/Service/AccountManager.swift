//
//  AccountManager.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/26.
//

import Foundation

protocol AccountServiceable {
    func getUserPillList() async throws -> [UserPillList]?
    func editUserName(for username: String) async throws -> UserNickNameEdit?
    func friendNicknameEdit(groupId: Int, memberName: String) async throws -> EditFriendNickname?
}

struct AccountManager: AccountServiceable {
    private let apiService: Requestable
    private let environment: APIEnvironment
    
    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getUserPillList() async throws -> [UserPillList]? {
        let request = AccountEndPoint
            .getUserPillList
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    func editUserName(for username: String) async throws -> UserNickNameEdit? {
        let request = AccountEndPoint
            .putUserNickNameEdit(username: username)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    func friendNicknameEdit(groupId: Int, memberName: String) async throws -> EditFriendNickname? {
        let request = AccountEndPoint
            .putFriendNicknameEdit(groupId: groupId, memberName: memberName)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
