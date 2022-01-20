//
//  CalendarViewController+ShareAPI.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/19.
//

import UIKit

// MARK: - Network(Main)
extension CalendarViewController {
    /*
     메인탭 일정, 약리스트
     */
    public func getSchedules(date: String) {
        ScheduleAPI.shared.getCalendar(date: date) { [weak self] response in
            switch response {
            case .success(let data):
                guard let data = data as? [Schedule] else { return }
                self?.scheduleItems = data
                self?.parseSchedules()
            default:
                return
            }
        }
    }
    
    public func parseSchedules() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.FormatType.full.description
        let items = scheduleItems.map { [dateFormatter.date(from: $0.scheduleDate) as Any, $0.isComplete] }
        
        for item in items {
            guard let scheduleDate = item[0] as? Date else { return }
            guard let isComplete = item[1] as? String else { return }
            
            if isComplete == "doing" {
                doingDates.append(scheduleDate.toString(of: .year))
            } else if isComplete == "done" {
                doneDates.append(scheduleDate.toString(of: .year))
            }
        }
    }
    
    public func getPillList(date: String) {
        ScheduleAPI.shared.getPillList(date: date) { response in
            switch response {
            case .success(let data):
                guard let data = data as? [PillList] else { return }
                self.pillItems = data
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.setCollectionViewHeight()
                    self.view.layoutIfNeeded()
                }
            default:
                return
            }
        }
    }
    
    /*
     복약 여부 체크
     */
    public func checkPillDetail(scheduleId: Int) {
        ScheduleAPI.shared.checkPill(scheduleId: scheduleId) {response in
            switch response {
            case .success(let data):
                print(data)
            default:
                return
            }
        }
    }
    
    public func uncheckPillDetail(scheduleId: Int) {
        ScheduleAPI.shared.uncheckPill(scheduleId: scheduleId) {response in
            switch response {
            case .success(let data):
                print(data)
            default:
                return
            }
        }
    }
    
    /*
     약 중단, 약 삭제
     */
    public func stopPillList(pillId: Int, day: String) {
        PillManagementAPI.shared.stopPillList(pillId: pillId, day: day) { response in
            print(response)
            switch response {
            case .success(let data):
                print(data)
            default:
                return
            }
        }
    }
    
    public func deletePillList(pillId: Int) {
        PillManagementAPI.shared.deletePillList(pillId: pillId) { response in
            print(response)
            switch response {
            case .success(let data):
                print(data)
            default:
                return
            }
        }
    }
}

// MARK: - Network(Share)

extension CalendarViewController {
    public func getFriendSchedules(memberId: Int, date: String) {
        ShareAPI.shared.getFriendCalendar(memberId: memberId, date: date) { [weak self] response in
            switch response {
            case .success(let data):
                guard let data = data as? [Schedule] else { return }
                self?.scheduleItems = data
                self?.parseSchedules()
            default:
                return
            }
        }
    }
    
    public func getFriendPillList(id: Int, date: String) {
        ShareAPI.shared.getFriendPillList(memberId: id, date: date) { response in
            switch response {
            case .success(let data):
                guard let data = data as? [PillList] else { return }
                self.pillItems = data
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.setCollectionViewHeight()
                    self.view.layoutIfNeeded()
                }
            default:
                return
            }
        }
    }
}

extension CalendarViewController {
    public func checkSticker(scheduleId: Int) {
        StickerAPI.shared.checkSticker(scheduleId: 1143) { response in
            switch response {
            case .success(let data):
                guard let data = data as? [Stickers] else { return }
//                print(data)
            default:
                return
            }
        }
    }
}
