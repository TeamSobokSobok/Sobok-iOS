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

extension ScheduleEndPoint: EndPoint {
    var method: HttpMethod {
        switch self {
        case .getMySchedule:
            return .GET
        case .getPillList:
            return .GET
        }
    }
    
    var body: Data? {
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
}
