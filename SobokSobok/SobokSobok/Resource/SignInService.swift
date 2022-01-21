//
//  SignInService.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/18.
//

import Foundation
import Moya

enum SignInService {
    case signIn (email: String, password: String)
}

extension SignInService: TargetType {
    
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .signIn(_, _):
            return URLs.signInURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn(_, _):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .signIn(let email, let password):
            return .requestParameters(parameters: [
                "email": email,
                "password": password
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
            return [
                "Content-Type": "application/json"
            ]
        }
}
