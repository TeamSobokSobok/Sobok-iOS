//
//  EditCommonViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/12.
//

import Foundation

class EditCommonViewModel {
    
    let addPillFirstViewModel: AddPillFirstViewModel
    let timeViewModel: PillTimeViewModel
    let dayViewModel: PillDayViewModel
    let periodViewModel: PillPeriodViewModel
    
    private let myInfoManager: AccountServiceable = AccountManager(apiService: APIManager(), environment: .development)
    private let editPillManager: PillEditServiceable = PillEditManager(apiService: APIManager(), environment: .development)
    private let scheduleManager: ScheduleServiceable = ScheduleManager(apiService: APIManager(), environment: .development)
    
    var pillName: Helper<String> = Helper("")
    let currentDate = Date()
    var pillId: Helper<Int> = Helper(0)
    var start: Helper<String> = Helper("")
    var end: Helper<String> = Helper("")
    var takeInterval: Helper<Int> = Helper(0)
    var scheduleDay: Helper<String> = Helper("")
    var scheduleSpecific: Helper<String> = Helper("")
    var changeTime: [String] = []
    var time: [String] = []

    var detailPillList: Helper<[DetailPillList]> = Helper([])
    
    init(addPillFirstViewModel: AddPillFirstViewModel, timeViewModel: PillTimeViewModel, dayViewModel: PillDayViewModel, periodViewModel: PillPeriodViewModel) {
        self.addPillFirstViewModel = addPillFirstViewModel
        self.timeViewModel = timeViewModel
        self.dayViewModel = dayViewModel
        self.periodViewModel = periodViewModel
    }
}

extension EditCommonViewModel {
    func putEditPill(pillId: Int) {
        Task {
            do {
                let editPill = EditPill(pillName: pillName.value,
                                        start: start.value, end: end.value, cycle: takeInterval.value, day: dayViewModel.days.value, specific: periodViewModel.dayPeriod.value, time: timeViewModel.changeTimeList.value, date: currentDate.toString(of: .year))
                
                _ = try await
                editPillManager.putEditPill(pillId: pillId, body: editPill)
            }
        }
    }
    
    func getUserDetailPillInfoList() {
        Task {
            do {
                guard let _ = try await myInfoManager.getUserDetailPillList(for: self.pillId.value) else { return }
            }
        }
    }
    
    func deletePill() {
        Task {
            do {
                guard let _ = try await scheduleManager.deletePillList(pillId: pillId.value) else { return }
            }
        }
    }
    
    func stopPillList() {
        Task {
            do {
                guard let _ = try await scheduleManager.stopPillList(pillId: pillId.value, date: currentDate.toString(of: .year)) else { return }
            }
        }
    }
}
