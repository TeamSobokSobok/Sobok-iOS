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
    
    init(addPillFirstViewModel: AddPillFirstViewModel, timeViewModel: PillTimeViewModel, dayViewModel: PillDayViewModel, periodViewModel: PillPeriodViewModel) {
        self.addPillFirstViewModel = addPillFirstViewModel
        self.timeViewModel = timeViewModel
        self.dayViewModel = dayViewModel
        self.periodViewModel = periodViewModel
    }
}
