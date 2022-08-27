//
//  PillThirdViewModel.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/08.
//

import Foundation
import UIKit

final class PillThirdViewModel {
    
    var addCellClosure: (() -> Void)?
    var deleteCellClosure: (() -> Void)?
    var pillList: Helper<[String]> = Helper([])
    var pillCount: Helper<Int> = Helper(5)
    var tag: Helper<Int> = Helper(0)
    
    func addCell() {
        pillList.value.append("")
        pillCount.value -= 1
    }
    
    func deleteCell(index: Int) {
        pillList.value.remove(at: index)
        pillCount.value += 1
    }
    
    func hideFooterView(button: inout Bool) {
        button = pillList.value.count == 5 ? true : false
    }
    
}
