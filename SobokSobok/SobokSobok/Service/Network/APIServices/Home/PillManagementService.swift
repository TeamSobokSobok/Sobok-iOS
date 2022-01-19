//
//  PillManagementService.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/19.
//

import Foundation

import Moya

enum PillManagementService {
    case stopPillList(pillId: Int, day: String)
    case deletePillList(pillId: Int)
}

extension PillManagementService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .stopPillList(let pillId, _):
            return URLs.stopPillListURL.replacingOccurrences(of: "{pillId}", with: "\(pillId)")
        case .deletePillList(let pillId):
            return URLs.deletePillURL.replacingOccurrences(of: "{pillId}", with: "\(pillId)")
        }
    }
        
    var method: Moya.Method {
        switch self {
        case .stopPillList:
            return .put
        case .deletePillList:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .stopPillList(_, let day):
            return .requestParameters(parameters: ["day": day], encoding: JSONEncoding.default)
        case .deletePillList:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .stopPillList, .deletePillList:
            return APIConstants.headerWithToken
        }
    }
}
