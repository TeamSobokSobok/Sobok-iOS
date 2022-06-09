//
//  Protocol ++ .swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/09.
//

import Foundation

// MARK: Protocol
protocol SendPillTimeDelegate: AnyObject {
    func snedPillTime(pillTime: String)
}

protocol SendPillDaysDelegate: AnyObject {
    func sendPillDays(pillDays: String)
}

protocol SendPillPeriodDelegate: AnyObject {
    func sendPillPeriod(pillPeriod: String)
}

// 모달에서 공통으로 쓰이는 부분
protocol PopUpDelegate: AnyObject {
    func popupDismissed()
}
