//
//  AuthManager.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/16.
//

import Foundation

protocol AuthServiceable {
    func signUp(body: SocialUserRequest) async throws -> SignUpResponse?
    func signIn(socialId: String, deviceToken: String) async throws -> SignInResponse?
}

struct AuthManager: AuthServiceable {
    private let apiService: Requestable
    private let environment: APIEnvironment
    
    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func signUp(body: SocialUserRequest) async throws -> SignUpResponse? {
        let request = AuthEndPoint
            .signUp(body: body)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func signIn(socialId: String, deviceToken: String) async throws -> SignInResponse? {
        let request = AuthEndPoint
            .signIn(socialId: socialId, deviceToken: deviceToken)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
