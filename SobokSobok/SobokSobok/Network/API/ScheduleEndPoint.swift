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
    case checkPillSchedule(scheduleId: Int)
    case uncheckPillSchedule(scheduleId: Int)
    case getGroupInformation
    case getMemberSchedule(memberId: Int, date: String)
    case getMemberPillList(memberId: Int, date: String)
    case deletePillList(pillId: Int)
    case stopPillList(pillId: Int, date: String)
}

extension ScheduleEndPoint: EndPoint {
    var method: HttpMethod {
        switch self {
        case .getMySchedule:
            return .GET
        case .getPillList:
            return .GET
        case .checkPillSchedule, .uncheckPillSchedule:
            return .PUT
        case .getGroupInformation:
            return .GET
        case .getMemberSchedule:
            return .GET
        case .getMemberPillList:
            return .GET
        case .deletePillList:
            return .DELETE
        case .stopPillList:
            return .PUT
        }
    }
    
    var body: Data? {
        switch self {
        case .getMySchedule:
            return nil
        case .getPillList:
            return nil
        case .checkPillSchedule, .uncheckPillSchedule:
            return nil
        case .getGroupInformation:
            return nil
        case .getMemberSchedule:
            return nil
        case .getMemberPillList:
            return nil
        case .deletePillList:
            return nil
        case .stopPillList(_, let date):
            let parameter = ["date" : date]
            return parameter.encode()
        }
    }
    
    func getURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .getMySchedule(let date):
            return "\(baseURL)/schedule/calendar?date=\(date)"
        case .getPillList(let date):
            return "\(baseURL)/schedule/detail?date=\(date)"
        case .checkPillSchedule(let scheduleId):
            return "\(baseURL)/schedule/check/\(scheduleId)"
        case .uncheckPillSchedule(let scheduleId):
            return "\(baseURL)/schedule/uncheck/\(scheduleId)"
        case .getGroupInformation:
            return "\(baseURL)/group"
        case .getMemberSchedule(let memberId, let date):
            return "\(baseURL)/schedule/\(memberId)/calendar?date=\(date)"
        case .getMemberPillList(let memberId, let date):
            return "\(baseURL)/schedule/\(memberId)/detail?date=\(date)"
        case .deletePillList(let pillId):
            return "\(baseURL)/pill/\(pillId)"
        case .stopPillList(let pillId, _):
            return "\(baseURL)/pill/stop/\(pillId)"
        }
    }
}
