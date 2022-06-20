//
//  PillDayViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/03.
//

import UIKit

import RxCocoa
import RxSwift

class PillDayViewModel {
    
    let weekArray: [String] = ["월", "화", "수", "목", "금", "토", "일"]

    var monday: Helper<String> = Helper("")
    var tuesday: Helper<String> = Helper("")
    var wednesday: Helper<String> = Helper("")
    var thursday: Helper<String> = Helper("")
    var friday: Helper<String> = Helper("")
    var saturday: Helper<String> = Helper("")
    var sunday: Helper<String> = Helper("")
    var days: Helper<String> = Helper("")
    
    var numOfRowInSection: Int {
        return weekArray.count
    }
    
    func selectDay(index: Int, isSelected: Bool) {
        let isBool = isSelected == false
        switch index {
        case 0:
            monday.value = isBool ? weekArray[0] : ""
        case 1:
            tuesday.value = isBool ? weekArray[1] : ""
        case 2:
            wednesday.value = isBool ? weekArray[2] : ""
        case 3:
            thursday.value = isBool ? weekArray[3] : ""
        case 4:
            friday.value = isBool ? weekArray[4] : ""
        case 5:
            saturday.value = isBool ? weekArray[5] : ""
        default:
            sunday.value = isBool ? weekArray[6] : ""
        }
        
        days.value = monday.value + tuesday.value + wednesday.value + thursday.value + friday.value + saturday.value + sunday.value
    }
}
