//
//  ScheduleService.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/18.
//

import Foundation

import Moya

enum ScheduleService {
    case getCalendar(date: String)
    case getPillList(date: String)
    case checkPillDetail(scheduleId: Int)
}

extension ScheduleService: TargetType {
    var baseURL: URL {
        return URL(string: URLs.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getCalendar:
            return URLs.getCalendarURL
        case .getPillList:
            return URLs.getPillListURL
        case .checkPillDetail(let scheduleId):
            return URLs.checkPillURL.replacingOccurrences(of: "{scheduleId}", with: "\(scheduleId)")
        }
    }
        
    var method: Moya.Method {
        switch self {
        case .getCalendar, .getPillList:
            return .get
        case .checkPillDetail:
            return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCalendar(let date), .getPillList(let date):
            return .requestParameters(parameters: ["date": date], encoding: URLEncoding.queryString)
        case .checkPillDetail:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getCalendar, .getPillList, .checkPillDetail:
            return APIConstants.headerWithToken
        }
    }
}
