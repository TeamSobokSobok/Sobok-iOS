//
//  CheckUsernameService.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/18.
//

import Foundation
import Moya

enum CheckUsernameService {
    case checkUsername(name: String)
}

extension CheckUsernameService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .checkUsername(_):
            return URLs.checkUsernameURL
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .checkUsername(_):
            return .post
        }
    }
    
    var sampleData: Data {
            return Data()
    }
    
    var task: Task {
        switch self {
        case .checkUsername(let name):
            return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    
}
