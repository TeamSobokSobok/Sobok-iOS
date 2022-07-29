//
//  ScheduleViewController+Network.swift
//  SobokSobok
//
//  Created by taekki on 2022/07/29.
//

extension ScheduleViewController {
    func getMySchedules(date: String) {
        Task {
            do {
                let schedules = try await scheduleManager.getMySchedule(for: date)
                if let schedules = schedules,
                   !schedules.isEmpty {
                    self.schedules = schedules
                }
            }
        }
    }
    
    func getMyPillLists(date: String) {
        Task {
            do {
                let pillLists = try await scheduleManager.getPillList(for: date)
                if let pillLists = pillLists,
                   !pillLists.isEmpty {
                    self.pillLists = pillLists
                }
            }
        }
    }
}
