//
//  AuthEndPoint.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/16.
//

import Foundation

enum AuthEndPoint {
    case signUp(socialId: String, username: String, deviceToken: String)
    case signIn(socialId: String, deviceToken: String)
    case fetchUsername
}

extension AuthEndPoint: EndPoint {
    var method: HttpMethod {
        switch self {
        case .signUp:
            return .POST
        case .signIn, .fetchUsername:
            return .GET
        }
    }
    
    var body: Data? {
        switch self {
        case .signUp(let socialId, let username, let deviceToken):
            let parameter = [
                "socialId": socialId,
                "username": username,
                "deviceToken": deviceToken
            ]
            return parameter.encode()
        case .signIn, .fetchUsername:
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
        case .fetchUsername:
            return "\(baseURL)/user/info"
        }
    }
    
    func createRequest(environment: APIEnvironment) -> NetworkRequest {
        
        switch self {
        case .signUp:
            var headers: [String: String] = [:]
            headers["Content-Type"] = "application/json"
            return NetworkRequest(url: getURL(from: environment),
                                  httpMethod: method,
                                  requestBody: body,
                                  headers: headers)
            
        case .signIn(let socialId, let deviceToken):
            var headers: [String: String] = [:]
            headers["Content-Type"] = "application/json"
            headers["socialId"] = socialId
            headers["deviceToken"] = deviceToken
            return NetworkRequest(url: getURL(from: environment),
                                  httpMethod: method,
                                  requestBody: body,
                                  headers: headers)
        case .fetchUsername:
            var headers: [String: String] = [:]
            headers["Content-Type"] = "application/json"
            headers["accesstoken"] = environment.token
            return NetworkRequest(url: getURL(from: environment),
                                  httpMethod: method,
                                  requestBody: body,
                                  headers: headers)
        }
    }
}
