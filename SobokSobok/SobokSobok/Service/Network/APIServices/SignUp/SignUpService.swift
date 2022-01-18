//
//  SignUpService.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/18.
//

import Foundation
import Moya

enum SignUpService {
    case signUp (email: String, password: String, nickname: String)
    case checkUsername (nickname: String)
}

extension SignUpService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signUp:
            return URLs.signUpURL
        case .checkUsername:
            return URLs.checkUsernameURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp:
            return .post
        case .checkUsername:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .signUp(let email, let password, let nickname):
            return .requestParameters(parameters: ["email": email, "password": password, "nickname": nickname], encoding: URLEncoding.queryString)
        case .checkUsername(let nickname):
            return .requestParameters(parameters: ["nickname": nickname], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
            return [
                "Content-Type": "application/json"
            ]
        }
    
    
}
