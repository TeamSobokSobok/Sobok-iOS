//
//  SendPillFirstViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/05.
//

import UIKit

final class SelectFriendViewModel {
    
    var memberNameList: Helper<[String]> = Helper([])
    var memberIdList: Helper<[Int]> = Helper([])
    var memberName: Helper<String> = Helper("")
    var memberId: Helper<Int> = Helper(0)
   
    func didSelectRowAt(_ pickerView: UIPickerView, row: Int, component: Int) {
        pickerView.reloadAllComponents()
        memberName.value = memberNameList.value[row]
        memberId.value = memberIdList.value[row]
    }
    
    func getMember() {
        UserDefaults.standard.member.forEach {
            memberNameList.value.append($0.memberName)
            memberIdList.value.append($0.memberId)
        }
    }
}
