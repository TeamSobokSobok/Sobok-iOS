//
//  PillDetailInfoModel.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/06.
//

import Foundation

struct PillDetailInfo: Codable {
    let pillName: String
    let takeInterval: Int
    let scheduleTime: [String]
    let startDate: String
    let endDate: String
    let scheduleDay: String?
    let scheduleSpecific: String?
    
    func makeTimeCount() -> Int {
        let counts = scheduleTime.count
        return counts
    }
}
