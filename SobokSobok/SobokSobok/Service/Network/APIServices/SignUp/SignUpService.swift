//
//  SignUpService.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/18.
//

import Foundation
import Moya

enum SignUpService {
    case signUp (email: String, password: String, name: String)
    case checkUsername (nickname: String)
}

extension SignUpService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signUp(_, _, _):
            return URLs.signUpURL
        case .checkUsername:
            return URLs.checkUsernameURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp(_, _, _):
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
        case .signUp(let email, let password, let name):
            return .requestParameters(parameters: [
                "email": email,
                "password": password,
                "name": name
            ], encoding: JSONEncoding.default)
        case .checkUsername(let name):
            return .requestParameters(parameters: ["name": name], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
            return [
                "Content-Type": "application/json"
            ]
        }
}
