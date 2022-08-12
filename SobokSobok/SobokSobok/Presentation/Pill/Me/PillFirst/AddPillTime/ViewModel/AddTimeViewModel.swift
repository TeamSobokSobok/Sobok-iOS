//
//  AddTimeViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/09.
//

import UIKit

class AddTimeViewModel {
    
    var addCellClosure: (() -> Void)?
    
    var morningList: Helper<[String]> = Helper(["오전", "오후"])
    var hourList: Helper<[String]> = Helper(["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"])
    var minuteList: Helper<[String]> = Helper([])
    var morning: Helper<String> = Helper("오전")
    var hour: Helper<String> = Helper("1")
    var minute: Helper<String> = Helper("00")
    var pillTime: Helper<String> = Helper("오전 1:00")

    func initTimeData() {
        for min in 0..<60 {
            var minute: String
            minute = min < 10 ? "0" + "\(min)" : "\(min)"
            minuteList.value += [minute]
        }
    }
    
    func numberOfRowsInComponent(_ component: Int) -> Int {
        switch component {
        case 0:
            return morningList.value.count
        case 1:
            return hourList.value.count
        default:
            return minuteList.value.count
        }
    }

    func titleForRow(_ component: Int, _ row: Int) -> String? {
        switch component {
        case 0:
            return morningList.value[row]
        case 1:
            return hourList.value[row]
        default:
            return minuteList.value[row]
        }
     }
    
    func didSelectRowAt(_ pickerView: UIPickerView, row: Int, component: Int) {
        pickerView.reloadAllComponents()
        switch component {
        case 0:
            morning.value = morningList.value[row]
        case 1:
            hour.value = hourList.value[row]
        default:
            minute.value = minuteList.value[row]
        }
        pillTime.value = morning.value + " " + hour.value + ":"  + minute.value
    }
}
