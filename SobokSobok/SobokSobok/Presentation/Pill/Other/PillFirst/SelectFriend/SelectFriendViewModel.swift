//
//  SendPillFirstViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/05.
//

import UIKit

final class SelectFriendViewModel {
    
    var memberNameList: Helper<[String]> = Helper([])
    var memberName: Helper<String> = Helper("")
    
    private let scheduleManager: ScheduleServiceable = ScheduleManager(apiService: APIManager(), environment: .development)
    
    func didSelectRowAt(_ pickerView: UIPickerView, row: Int, component: Int) {
        pickerView.reloadAllComponents()
        memberName.value = memberNameList.value[row]
    }
}

extension SelectFriendViewModel {
    func getGroupInformation() {
        Task {
            do {
                let members = try await scheduleManager.getGroupInformation()
                
                guard let members = members else {
                    return
                }
                
                members.forEach {
                    memberNameList.value.append($0.memberName)
                }
            }
        }
    }
}
