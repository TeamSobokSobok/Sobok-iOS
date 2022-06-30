//
//  ScheduleEndPoint.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/30.
//

import Foundation

enum ScheduleEndPoint {
    case getMySchedule(date: String)
    case getPillList(date: String)
}

extension ScheduleEndPoint {
    var httpMethod: HttpMethod {
        switch self {
        case .getMySchedule:
            return .GET
        case .getPillList:
            return .GET
        }
    }
    
    var requestBody: Data? {
        switch self {
        case .getMySchedule:
            return nil
        case .getPillList:
            return nil
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .getMySchedule(let date):
            return "\(baseURL)/schedule/calendar?date=\(date)"
        case .getPillList(let date):
            return "\(baseURL)/schedule/detail?date=\(date)"
        }
    }
    
    func createRequest(environment: APIEnvironment) -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["accesstoken"] = environment.token
        return NetworkRequest(url: getURL(from: environment),
                              httpMethod: httpMethod,
                              requestBody: requestBody,
                              headers: headers)
    }
}
