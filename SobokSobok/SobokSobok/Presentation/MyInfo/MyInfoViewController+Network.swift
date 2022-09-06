//
//  MyInfoViewController+Network.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/26.
//

extension MyInfoViewController {
    
    func getUserPillInfoList() {
        Task {
            do {
                let userPillList = try await myInfoManager.getUserPillList()
                if let userPillList = userPillList,
                   !userPillList.isEmpty {
                    self.userPillList = userPillList
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
}
