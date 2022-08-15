//
//  EditTimeViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/12.
//

import Foundation

class EditTimeViewModel {
    var timeList: Helper<[String]> = Helper(["오전 8:00", "오후 1:00", "오후 7:00"])
    
    func deleteCell(index: Int) {
        timeList.value.remove(at: index)
    }
    
    func addPillTime(pillTime: String) {
        timeList.value += [pillTime]
    }
    
    func hideFooterView(button: inout Bool) {
        button = timeList.value.count == 4 ? true : false
    }
}
