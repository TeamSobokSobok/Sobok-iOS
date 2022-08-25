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
    
    let editPillManager: PillEditServiceable = PillEditManager(apiService: APIManager(), environment: .development)
    
    var textFieldText: Helper<String> = Helper("")
    
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
//                let editPill = EditPill(pillName: textFieldText.value,
//                                        start: , end: <#T##String#>, cycle: <#T##Int#>, day: <#T##String?#>, specific: <#T##String?#>, time: <#T##[String]#>, date: <#T##String#>)
//                
//                _ = try await
//                editPillManager.putEditPill(pillId: pillId, body: EditPill)
            }
        }
    }
}
