//
//  CalendarViewController+ShareAPI.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/19.
//

import UIKit

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
    
    public func getFriendPillList(memberId: Int, date: String) {
        ShareAPI.shared.getFriendPillList(memberId: memberId, date: date) { response in
            print(22222, response)
            switch response {
            case .success(let data):
                guard let data = data as? [PillList] else { return }
                print(33333, data)
            default:
                return
            }
        }
    }
}
