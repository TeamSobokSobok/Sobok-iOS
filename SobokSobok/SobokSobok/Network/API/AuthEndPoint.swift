//
//  AuthEndPoint.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/16.
//

import Foundation

enum AuthEndPoint {
    case signUp(body: SocialUserRequest)
    case signIn(socialId: String, deviceToken: String)
}

extension AuthEndPoint: EndPoint {
    var method: HttpMethod {
        switch self {
        case .signUp:
            return .POST
        case .signIn:
            return .GET
        }
    }
    
    var body: Data? {
        switch self {
        case .signUp(let body):
            return body.encode()
        case .signIn:
            return nil
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .signUp:
            return "\(baseURL)/auth/signup"
        case .signIn(let socialId, let deviceToken):
            return "\(baseURL)/auth/signin?socialId=\(socialId)&deviceToken=\(deviceToken)"
        }
    }
}
