//
//  PillEditManager.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/25.
//

import Foundation

protocol PillEditServiceable {
    func putEditPill(pillId: Int, body: EditPill) async throws -> EditPill?
}

struct PillEditManager: PillEditServiceable {
    private let apiService: Requestable
    private let environment: APIEnvironment
    
    
    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func putEditPill(pillId: Int, body: EditPill) async throws -> EditPill? {
        let request = PillEditEndPoint.putEditPill(pillId: pillId, body: body)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
