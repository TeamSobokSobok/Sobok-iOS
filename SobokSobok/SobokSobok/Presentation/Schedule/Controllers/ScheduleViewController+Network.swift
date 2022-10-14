//
//  ScheduleViewController+Network.swift
//  SobokSobok
//
//  Created by taekki on 2022/07/29.
//

import Foundation

extension ScheduleViewController {
    func getMySchedules(date: Date) {
        Task {
            do {
                let prev = Calendar.current.date(byAdding: .month, value: -1, to: date)!.toString(of: .year)
                let current = date.toString(of: .year)
                let next = Calendar.current.date(byAdding: .month, value: 1, to: date)!.toString(of: .year)

                var tmp: [Schedule] = []
                for date in [prev, current, next] {
                    let schedules = try await scheduleManager.getMySchedule(for: date)
                    if let schedules = schedules,
                       !schedules.isEmpty {
                        tmp.append(contentsOf: schedules)
                    }
                }
                
                if tmp != self.schedules {
                    self.schedules.removeAll()
                    self.schedules = tmp
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
    
    func getUserDetailPillInfoList(pillId: Int) {
        Task {
            do {
                guard let detailPillList = try await myInfoManager.getUserDetailPillList(for: pillId) else { return }

                guard let detail = detailPillList.first else { return }
                
                editPillViewModel.pillName.value = detail.pillName
                editPillViewModel.takeInterval.value = detail.takeInterval
                editPillViewModel.timeViewModel.changeTimeList.value = detail.time
                editPillViewModel.dayViewModel.days.value = detail.scheduleDay ?? ""
                editPillViewModel.periodViewModel.dayString.value = detail.scheduleSpecific ?? ""
  
                let startDate = transformString(string: detail.startDate)
                let endDate = transformString(string: detail.endDate)
                let time = transformStringToInt(detail.time)
                
                editPillViewModel.start.value = startDate
                editPillViewModel.end.value = endDate
                editPillViewModel.timeViewModel.timeList.value = time
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
