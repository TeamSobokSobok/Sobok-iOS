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
    
    func checkPillSchedule(scheduleId: Int, completion: @escaping (() ->())) {
        Task {
            do {
                let _ = try await scheduleManager.checkPillSchedule(for: scheduleId)
                completion()
            }
        }
    }
    
    func uncheckPillSchedule(scheduleId: Int, completion: @escaping (() -> ())) {
        Task {
            do {
                let _ = try await scheduleManager.uncheckPillSchedule(for: scheduleId)
                completion()
            }
        }
    }
    
    func getMemberSchedules(memberId: Int, date: String) {
        Task {
            do {
                let schedules = try await scheduleManager.getMemberSchedule(memberId: memberId, date: date)
                if let schedules = schedules,
                   !schedules.isEmpty {
                    self.schedules = schedules
                    self.calendarView.reloadData()
                }
            }
        }
    }
    
    func getMemberPillLists(memberId: Int, date: String) {
        Task {
            do {
                let pillLists = try await scheduleManager.getMemberPillList(memberId: memberId, date: date)
                if let pillLists = pillLists {
                    self.pillLists = pillLists
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func getStickers(for scheduleId: Int, completion: (() -> ())? = nil) {
        Task {
            do {
                guard let stickers = try await stickerManageer.getStickers(for: scheduleId) else { return }
                self.stickers = stickers
                completion?()
            }
        }
    }
    
    func postSticker(for scheduleId: Int, withSticker stickerId: Int, completion: @escaping (() -> ())) {
        Task {
            do {
                let _ = try await stickerManageer.postStickers(for: scheduleId, withSticker: stickerId)
                completion()
            }
        }
    }
    
    func changeSticker(for likeScheduleId: Int, withSticker stickerId: Int, completion: @escaping (() -> ())) {
        Task {
            do {
                let _ = try await stickerManageer.changeSticker(for: likeScheduleId, withSticker: stickerId)
                completion()
            }
        }
    }
}
