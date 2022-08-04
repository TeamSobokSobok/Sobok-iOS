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
                    self.calendarView.reloadData()
                }
            }
        }
    }
    
    func getMyPillLists(date: String) {
        Task {
            do {
                let pillLists = try await scheduleManager.getPillList(for: date)
                if let pillLists = pillLists {
                    self.pillLists = pillLists
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func checkPillSchedule(scheduleId: Int) {
        Task {
            do {
                let _ = try await scheduleManager.checkPillSchedule(for: scheduleId)
            }
        }
    }
    
    func uncheckPillSchedule(scheduleId: Int, completion: (() -> ())? = nil) {
        Task {
            do {
                let _ = try await scheduleManager.uncheckPillSchedule(for: scheduleId)
            }
        }
    }
    
    func getMemberSchedules(memberId: Int, date: String) {
        Task {
            do {
                let _ = try await scheduleManager.getMemberSchedule(memberId: memberId, date: date)
            }
        }
    }
    
    func getMemberPillLists(memberId: Int, date: String) {
        Task {
            do {
                let _ = try await scheduleManager.getMemberPillList(memberId: memberId, date: date)
            }
        }
    }
    
    func getStickers(for scheduleId: Int) {
        Task {
            do {
                let stickers = try await stickerManageer.getStickers(for: scheduleId)
                self.showStickerBottomSheet(stickers: stickers)
            }
        }
    }
    
    func postSticker(for scheduleId: Int, withSticker stickerId: Int) {
        Task {
            do {
                let _ = try await stickerManageer.postStickers(for: scheduleId, withSticker: stickerId)
            }
        }
    }
    
    func changeSticker(for likeScheduleId: Int, withSticker stickerId: Int) {
        Task {
            do {
                let _ = try await stickerManageer.changeSticker(for: likeScheduleId, withSticker: stickerId)
            }
        }
    }
}
