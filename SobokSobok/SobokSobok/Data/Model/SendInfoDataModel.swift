//
//  SendInfoDataModel.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

struct SendInfoData: Hashable {
    let pillInfo: String
    let termInfo: String
    let timeInfo: [String]
    let periodInfo: String
    
    func makeTimeCount() -> Int {
        let counts = timeInfo.count
        return counts
    }
}

extension SendInfoData {
    static let dummy: [SendInfoData] = [
        SendInfoData(pillInfo: "정관장",
                     termInfo: "월, 화, 수, 목, 금, 토",
                     timeInfo: ["오전 10:00", "오후 12:30", "오후 3:00", "오후 5:20", "오후 7:30", "오후 10:50"],
                     periodInfo: "2022.1.9 ~ 2022.4.9")
    ]
}
