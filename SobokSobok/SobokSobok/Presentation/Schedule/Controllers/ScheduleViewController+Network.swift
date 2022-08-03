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
    
    func checkPillSchedule(scheduleId: Int) {
        Task {
            do {
                let result = try await scheduleManager.checkPillSchedule(for: scheduleId)
                print("check", result)
            }
        }
    }
    
    func uncheckPillSchedule(scheduleId: Int) {
        Task {
            do {
                let result = try await scheduleManager.uncheckPillSchedule(for: scheduleId)
                print("uncheck", result)
            }
        }
    }
    
    func getMemberSchedules(memberId: Int, date: String) {
        Task {
            do {
                let result = try await scheduleManager.getMemberSchedule(memberId: memberId, date: date)
            }
        }
    }
    
    func getMemberPillLists(memberId: Int, date: String) {
        Task {
            do {
                let result = try await scheduleManager.getMemberPillList(memberId: memberId, date: date)
                print(22222, result)
            }
        }
    }
    
    func getStickers(for scheduleId: Int) {
        Task {
            do {
                let stickers = try await stickerManageer.getStickers(for: scheduleId)
                print(33333, stickers)
            }
        }
    }
    
    func postSticker(for scheduleId: Int, withSticker stickerId: Int) {
        Task {
            do {
                let result = try await stickerManageer.postStickers(for: scheduleId, withSticker: stickerId)
                print(44444, result)
            }
        }
    }
}
