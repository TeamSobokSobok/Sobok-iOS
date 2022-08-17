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
    var pillList: Helper<[String]> = Helper(["", "", "", "", ""])
    
    var data = Helper([])
   
}
