//
//  PillStyle.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/07/25.
//

import Foundation

protocol TossPillProtocol {
    var type: TossPill { get }
}

enum TossPill: Int {
    case myPill = 0
    case friendPill
}

protocol NavigationIsHiddenProtocol {
    var bottomNavigationBarIsHidden: Bool { get }
    var sendBottomNavigationBarIsHidden: Bool { get }
}

struct PillStyle: TossPillProtocol, NavigationIsHiddenProtocol {
    var type: TossPill
    let bottomNavigationBarIsHidden: Bool
    let sendBottomNavigationBarIsHidden: Bool
    
    static var myPill: PillStyle {
        
        return PillStyle(
            type: .myPill, bottomNavigationBarIsHidden: false,
            sendBottomNavigationBarIsHidden: true
        )
    }
    
    static var friendPill: PillStyle {
        
        return PillStyle(
            type: .friendPill, bottomNavigationBarIsHidden: true,
            sendBottomNavigationBarIsHidden: false
        )
    }
}
