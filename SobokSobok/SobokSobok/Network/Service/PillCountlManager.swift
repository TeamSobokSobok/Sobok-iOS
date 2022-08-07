//
//  AddPillManager.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/03.
//

import Foundation

protocol PillCountServiceable {
    func getMyPillCount() async throws -> PillCount?
    func getFriendPillCount(for userId: Int) async throws -> PillCount?
}

struct PillCountManager: PillCountServiceable {
    
    private let apiService: Requestable
    private let environment: APIEnvironment
    
    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getMyPillCount() async throws -> PillCount? {
        let request = PillCountEndPoint
            .getMyPillCount
            .createRequest(environment: environment)
        
        return try await self.apiService.request(request)
    }
    
    func getFriendPillCount(for userId: Int) async throws -> PillCount? {
        let request = PillCountEndPoint
            .getFriendPillCount(userId: userId)
            .createRequest(environment: environment)
        
        return try await self.apiService.request(request)
    }
}
