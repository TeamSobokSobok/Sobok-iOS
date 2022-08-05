//
//  NoticeManager.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/05.
//

import Foundation

protocol NoticeServiceable {
    func getNoticeList() async throws -> NoticeList?
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
}
