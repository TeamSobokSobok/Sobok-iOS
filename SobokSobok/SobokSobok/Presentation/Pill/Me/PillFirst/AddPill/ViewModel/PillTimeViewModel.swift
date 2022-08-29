//
//  PillTimeViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/09.
//

import Foundation

class PillTimeViewModel {
    var timeList: Helper<[String]> = Helper(["오전 8:00", "오후 1:00", "오후 7:00"])
    
    var changeTimeList: Helper<[String]> = Helper(["08:00:00", "13:00:00", "19:00:00"])

    var deleteCellClosure: (() -> Void)?
    
    var numberOfItemsInSection: Int {
        return timeList.value.count
    }
    
    func deleteCell(index: Int) {
        timeList.value.remove(at: index)
        changeTimeList.value.remove(at: index)
    }
    
    func addPillTime(pillTime: String) {
        timeList.value += [pillTime]
    }
    
    func addChangeTime(pillTime: String) {
        changeTimeList.value += [pillTime]
    }
    
    func hideFooterView(button: inout Bool) {
        button = timeList.value.count == 4 ? true : false
    }
}
