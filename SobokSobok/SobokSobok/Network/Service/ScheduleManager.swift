//
//  ScheduleService.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/30.
//

import Foundation
import Alamofire

protocol ScheduleServiceable {
    func getMySchedule(for date: String) async throws -> [Schedule]?
    func getPillList(for date: String) async throws -> [PillList]?
    func checkPillSchedule(for scheduleId: Int) async throws -> PillDetail?
    func uncheckPillSchedule(for scheduleId: Int) async throws -> PillDetail?
    func getGroupInformation() async throws -> [Member]?
    func getMemberSchedule(memberId: Int, date: String) async throws -> [Schedule]?
    func getMemberPillList(memberId: Int, date: String) async throws -> [PillList]?
    func deletePillList(pillId: Int) async throws -> EmptyData?
    func stopPillList(pillId: Int, date: String) async throws -> EmptyData?
}

struct ScheduleManager: ScheduleServiceable {
    private let apiService: Requestable
    private let environment: APIEnvironment
    
    init(apiService: Requestable, environment: APIEnvironment) {
        self.apiService = apiService
        self.environment = environment
    }
    
    func getMySchedule(for date: String) async throws -> [Schedule]? {
        let request = ScheduleEndPoint
            .getMySchedule(date: date)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func getPillList(for date: String) async throws -> [PillList]? {
        let request = ScheduleEndPoint
            .getPillList(date: date)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func checkPillSchedule(for scheduleId: Int) async throws -> PillDetail? {
        let request = ScheduleEndPoint
            .checkPillSchedule(scheduleId: scheduleId)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func uncheckPillSchedule(for scheduleId: Int) async throws -> PillDetail? {
        let request = ScheduleEndPoint
            .uncheckPillSchedule(scheduleId: scheduleId)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func getGroupInformation() async throws -> [Member]? {
        let request = ScheduleEndPoint
            .getGroupInformation
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func getMemberSchedule(memberId: Int, date: String) async throws -> [Schedule]? {
        let request = ScheduleEndPoint
            .getMemberSchedule(memberId: memberId, date: date)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func getMemberPillList(memberId: Int, date: String) async throws -> [PillList]? {
        let request = ScheduleEndPoint
            .getMemberPillList(memberId: memberId, date: date)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func deletePillList(pillId: Int) async throws -> EmptyData? {
        let request = ScheduleEndPoint
            .deletePillList(pillId: pillId)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
    
    func stopPillList(pillId: Int, date: String) async throws -> EmptyData? {
        let request = ScheduleEndPoint
            .stopPillList(pillId: pillId, date: date)
            .createRequest(environment: environment)
        return try await self.apiService.request(request)
    }
}
