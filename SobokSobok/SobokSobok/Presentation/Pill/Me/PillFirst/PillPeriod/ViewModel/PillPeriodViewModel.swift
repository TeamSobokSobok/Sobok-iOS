//
//  PillPeriodViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/04.
//

import UIKit

class PillPeriodViewModel {
    
    var numberList: Helper<[String]> = Helper(["1", "2", "3"])
    var periodList: Helper<[String]> = Helper(["일에 한 번", "주에 한 번", "달에 한 번"])
    var component: Int?
    var day: Helper<String> = Helper("1")
    var period: Helper<String> = Helper("일에 한 번")
    var dayPeriod: Helper<String> = Helper("1일에 한 번")
    
    var dayString: Helper<String> = Helper("")
    
    var numberOfRowsInComponent: Int {
        return component == 0 ? numberList.value.count : periodList.value.count
    }

    func titleForRow(_ component: Int, _ row: Int) -> String? {
        return component == 0 ? numberList.value[row] : periodList.value[row]
     }
    
    func didSelectRowAt(_ pickerView: UIPickerView, row: Int, component: Int) {
        pickerView.reloadAllComponents()
        if component == 0 {
            day.value = numberList.value[row]
        } else {
            period.value = periodList.value[row]
        }
        dayPeriod.value = day.value + period.value
        dayString.value = dayPeriod.value
    }
}
